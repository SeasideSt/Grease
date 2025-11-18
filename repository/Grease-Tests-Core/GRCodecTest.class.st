Class {
	#name : 'GRCodecTest',
	#superclass : 'TestCase',
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'private' }
GRCodecTest >> asString: aCollectionOfIntegers [
	^ String streamContents: [ :stream |
		aCollectionOfIntegers do: [ :each |
			stream nextPut: (Character codePoint: each) ] ]
]

{ #category : 'accessing' }
GRCodecTest >> decodedString [
	^ 'Übèrstrîñgé'
]

{ #category : 'accessing' }
GRCodecTest >> latin1String [
	^ self asString: #(220 98 232 114 115 116 114 238 241 103 233)
]

{ #category : 'accessing' }
GRCodecTest >> macromanString [
	^ self asString: #(134 98 143 114 115 116 114 148 150 103 142)
]

{ #category : 'private' }
GRCodecTest >> seasideByteArray [
	^ #(83 101 97 115 105 100 101) "Seaside" asByteArray
]

{ #category : 'tests' }
GRCodecTest >> testAllCodecs [
	self assert: GRCodec allCodecs notEmpty.
	GRCodec allCodecs do: [ :codec | 
		self deny: codec class = GRCodec.
		self assert: (codec isKindOf: GRCodec) ]
]

{ #category : 'tests' }
GRCodecTest >> testCodecLatin1 [
	#('iso-8859-1' 'ISO-8859-1' ) do:  [ :each | 
		| codec |
		codec := GRCodec forEncoding: each.
		self assert: codec name = each.
		self assert: codec url name = each.
		
		"Dialects may not guarantee anything about the comparability of
		 encoded strings.  Convert to Strings for simplicity."
		self assert: (codec encode: self decodedString) greaseString = self latin1String greaseString.
		self assert: (codec url encode: self decodedString) greaseString = self latin1String greaseString.
		self assert: (codec decode: self latin1String) = self decodedString.
		self assert: (codec url decode: self latin1String) = self decodedString ]
]

{ #category : 'tests' }
GRCodecTest >> testCodecLatin1BorderLineString [
	#('iso-8859-1' 'ISO-8859-1' ) do:  [ :each | 
		| codec writeStream |
		codec := GRCodec forEncoding: each.
		writeStream := codec encoderFor: GRPlatform current readWriteCharacterStream.
		writeStream nextPut: (Character codePoint: 0).
		writeStream nextPut: (Character codePoint: 255).
		self assert: writeStream contents = (String with: (Character codePoint: 0) with: (Character codePoint: 255)) ]
]

{ #category : 'tests' }
GRCodecTest >> testNext [
	#('iso-8859-1' 'ISO-8859-1' ) do:  [ :each | 
		| stream |
		stream := (GRCodec forEncoding: each)
			encoderFor: self seasideByteArray readStream.
		self assert: stream next = $S.
		self assert: (stream next: 1) = 'e' ]
]

{ #category : 'tests' }
GRCodecTest >> testNullCodec [
	| codec strings |
	codec := GRNullCodec new.
	strings := OrderedCollection new
		add: self latin1String;
		add: self utf8String;
		add: self utf16leString;
		add: self utf16beString;
		add: self macromanString;
		yourself.
	strings do:  [ :string | 
		self assert: (codec encode: string) = string.
		self assert: (codec url encode: string) = string.
		self assert: (codec decode: string) = string.
		self assert: (codec url decode: string) = string ]
]

{ #category : 'tests' }
GRCodecTest >> testReset [
	| contents |
	contents := String streamContents: [ :s |
		| stream |
		stream := (GRCodec forEncoding: 'ISO-8859-1') encoderFor: s.
		stream
			nextPutAll: 'abc';
			reset;
			nextPut: $d ].
	self assert: contents = 'd'
]

{ #category : 'accessing' }
GRCodecTest >> utf16beString [
	^ self asString: #(0 220 0 98 0 232 0 114 0 115 0 116 0 114 0 238 0 241 0 103 0 233)
]

{ #category : 'accessing' }
GRCodecTest >> utf16leString [
	^ self asString: #(220 0 98 0 232 0 114 0 115 0 116 0 114 0 238 0 241 0 103 0 233 0)
]

{ #category : 'accessing' }
GRCodecTest >> utf8String [
	^ self asString: #(195 156 98 195 168 114 115 116 114 195 174 195 177 103 195 169)
]
