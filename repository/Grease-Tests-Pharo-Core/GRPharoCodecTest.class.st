Class {
	#name : 'GRPharoCodecTest',
	#superclass : 'TestCase',
	#category : 'Grease-Tests-Pharo-Core',
	#package : 'Grease-Tests-Pharo-Core'
}

{ #category : 'private' }
GRPharoCodecTest >> assert: aString next: anInteger startingAt: startIndex gives: anEncodedString [
	| actual encoder |
	encoder := GRCodec forEncoding: 'utf-8'.
	actual := encoder encodedStringClass streamContents: [ :stream |
		((GRCodec forEncoding: 'utf-8') encoderFor: stream)
			greaseNext: anInteger putAll: aString startingAt: startIndex ].
	encoder encodedStringClass == ByteArray
		ifTrue:[ self assert: actual = anEncodedString asByteArray ]
		ifFalse:[ self assert: actual = anEncodedString ]
]

{ #category : 'private' }
GRPharoCodecTest >> assertEncodingIgnoresLanguageTat: aStringWithLanguageTag [
	| codec withLanguageTag withoutLanguageTag |
	codec := GRCodec forEncoding: 'utf-8'.
	withLanguageTag := codec encode: aStringWithLanguageTag.
	withoutLanguageTag := codec encode: (self stripLeadingCharFrom: aStringWithLanguageTag).
	self assert: withLanguageTag = withoutLanguageTag
]

{ #category : 'private' }
GRPharoCodecTest >> stripLeadingCharFrom: aString [ 
	"strips the leadingChar from every character in the given string"
	^ String streamContents: [ :stream | 
		aString do: [ :each | 
			stream nextPut: (Character 
				leadingChar: 0
				code: each greaseInteger) ] ]
]

{ #category : 'tests' }
GRPharoCodecTest >> testAllCodesIncludesIso88591 [
	self assert: (GRCodec allCodecs anySatisfy: [ :each |
		each name = 'iso-8859-1' ])
]

{ #category : 'tests' }
GRPharoCodecTest >> testGreaseNextPutAllStartingAt [
	| umlaut encodedUmlaut |
	umlaut := String with: (Character codePoint: 228).
	((GRCodec forEncoding: 'utf-8') encodedStringClass == ByteArray)
		ifTrue:[ 	encodedUmlaut := ByteArray with: 195 with: 164 ]
		ifFalse:[ encodedUmlaut := String with: (Character codePoint: 195) with: (Character codePoint: 164) ].
	self assert: 'ab' next: 1 startingAt: 1 gives:  'a'.
	self assert: 'a', umlaut, 'b' next: 1 startingAt: 1 gives: 'a'.
	self assert: 'ab', umlaut next: 1 startingAt: 1 gives: 'a'.
	self assert: 'a', umlaut, 'b' next: 2 startingAt: 1 gives: 'a', encodedUmlaut.
	self assert: 'a', umlaut, 'b' next: 1 startingAt: 2 gives: encodedUmlaut.
	self assert: 'a', umlaut, 'b' next: 2 startingAt: 2 gives: encodedUmlaut, 'b'.
	self assert: 'a', umlaut, umlaut next: 2 startingAt: 2 gives: encodedUmlaut, encodedUmlaut.
	self assert: 'ab', umlaut, 'b', umlaut next: 3 startingAt: 2 gives: 'b', encodedUmlaut, 'b'
]
