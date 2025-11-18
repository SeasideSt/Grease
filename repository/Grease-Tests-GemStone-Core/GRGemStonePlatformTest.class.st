Class {
	#name : 'GRGemStonePlatformTest',
	#superclass : 'TestCase',
	#category : 'Grease-Tests-GemStone-Core',
	#package : 'Grease-Tests-GemStone-Core'
}

{ #category : 'testing' }
GRGemStonePlatformTest >> testCompileIntoClassified [
	| source protocol selectors selector |
	source := 'aMethod
	^ ''a result'''.
	protocol := 'a-protocol'.
	selector := #aMethod.

	GRPlatform current compile: source into: self class classified: protocol.
	[
		self assert: (self class selectors includes: selector).
		selectors := self class organization listAtCategoryNamed: protocol.
		self assert: selectors = (Array with: selector).
	 ] ensure: [
		self class removeSelectorSilently: selector.
	].
]

{ #category : 'testing' }
GRGemStonePlatformTest >> testConvertToSmalltalkNewlines [
	"GemStone uses lf as native newline character"

	| expected got codePoint euro |
	expected := 'selector', String lf, '"comment"'.
	got := GRPlatform current convertToSmalltalkNewlines: expected.
	codePoint := (got at: 9) codePoint.
	self assert: expected = got.
	self assert: expected = (GRPlatform current
		convertToSmalltalkNewlines: ('selector', String lf, '"comment"')).
	self assert: expected = (GRPlatform current
		convertToSmalltalkNewlines: ('selector', String crlf, '"comment"')).
		
	euro := (String with: (Character value: 8364)).
	self assert: expected, euro = (GRPlatform current
		convertToSmalltalkNewlines: expected, euro).
		
	self assert: (GRPlatform current convertToSmalltalkNewlines: nil) isNil
]

{ #category : 'as yet unclassified' }
GRGemStonePlatformTest >> testEncoderForUtf8Roundtrip [
	| codec encoded string writeStream |
	codec := GRCodec forEncoding: 'utf-8'.
	"byte array with utf8 encoded characters 'a umlaut' and 'a'"
	encoded := ByteArray with: 195 with: 164 with: 97.
	string := (codec decoderFor: encoded readStream) next: 10.
	self assert: string size = 2.
	self assert: (string at: 1) asciiValue = 228.
	self assert: (string at: 2) asciiValue = 97.
	writeStream := String new writeStream.
	self assert: ((codec encoderFor: writeStream) nextPutAll: string) contents = encoded.
]

{ #category : 'testing' }
GRGemStonePlatformTest >> testFullName [
	self assert: Object fullName = #'Object'
]
