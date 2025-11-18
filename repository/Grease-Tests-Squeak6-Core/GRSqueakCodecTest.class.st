Class {
	#name : 'GRSqueakCodecTest',
	#superclass : 'TestCase',
	#category : 'Grease-Tests-Squeak6-Core',
	#package : 'Grease-Tests-Squeak6-Core'
}

{ #category : 'private' }
GRSqueakCodecTest >> assert: aString next: anInteger startingAt: startIndex gives: anEncodedString [
	| actual |
	actual := String streamContents: [ :stream |
		((GRCodec forEncoding: 'utf-8') encoderFor: stream)
			greaseNext: anInteger putAll: aString startingAt: startIndex ].
	self assert: actual = anEncodedString
]

{ #category : 'private' }
GRSqueakCodecTest >> assertEncodingIgnoresLanguageTat: aStringWithLanguageTag [
	| codec withLanguageTag withoutLanguageTag |
	codec := GRCodec forEncoding: 'utf-8'.
	withLanguageTag := codec encode: aStringWithLanguageTag.
	withoutLanguageTag := codec encode: (self stripLeadingCharFrom: aStringWithLanguageTag).
	self assert: withLanguageTag = withoutLanguageTag
]

{ #category : 'private' }
GRSqueakCodecTest >> stripLeadingCharFrom: aString [ 
	"strips the leadingChar from every character in the given string"
	^ String streamContents: [ :stream | 
		aString do: [ :each | 
			stream nextPut: (Character 
				leadingChar: 0
				code: each greaseInteger) ] ]
]

{ #category : 'tests' }
GRSqueakCodecTest >> testAllCodesIncludesIso88591 [
	self assert: (GRCodec allCodecs anySatisfy: [ :each |
		each name = 'iso-8859-1' ])
]

{ #category : 'tests' }
GRSqueakCodecTest >> testGreaseNextPutAllStartingAt [
	| umlaut encodedUmlaut |
	umlaut := String with: (Character codePoint: 228).
	encodedUmlaut := String with: (Character codePoint: 195) with: (Character codePoint: 164).
	self assert: 'ab' next: 1 startingAt: 1 gives:  'a'.
	self assert: 'a', umlaut, 'b' next: 1 startingAt: 1 gives:  'a'.
	self assert: 'ab', umlaut next: 1 startingAt: 1 gives:  'a'.
	self assert: 'a', umlaut, 'b' next: 2 startingAt: 1gives:  'a', encodedUmlaut.
	self assert: 'a', umlaut, 'b' next: 1 startingAt: 2 gives:  encodedUmlaut.
	self assert: 'a', umlaut, 'b' next: 2 startingAt: 2 gives:  encodedUmlaut, 'b'.
	self assert: 'a', umlaut, umlaut next: 2 startingAt: 2 gives:  encodedUmlaut, encodedUmlaut.
	self assert: 'ab', umlaut, 'b', umlaut next: 3 startingAt: 2 gives:  'b', encodedUmlaut, 'b'
]

{ #category : 'tests' }
GRSqueakCodecTest >> testLanguageTag [
	"this makes sure the encoder doesn't fall on the nose with unicode"
	"Make Japanese String from unicode. see http://www.unicode.org/charts/PDF/U3040.pdf"
	| leading hiraA hiraO hiraAO |
	leading := (Smalltalk classNamed: #JapaneseEnvironment) leadingChar.
	hiraA := (Character 
		leadingChar: leading
		code: 12354) greaseString.	"HIRAGANA LETTER A"
	hiraO := (Character 
		leadingChar: leading
		code: 12362) greaseString.	"HIRAGANA LETTER O"
	hiraAO := hiraA , hiraO.
	self assertEncodingIgnoresLanguageTat: hiraA.
	self assertEncodingIgnoresLanguageTat: hiraO.
	self assertEncodingIgnoresLanguageTat: hiraAO
]
