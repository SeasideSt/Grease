Class {
	#name : 'GRUtf8CodecTest',
	#superclass : 'TestCase',
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'private' }
GRUtf8CodecTest >> asByteArray: aCollectionOfIntegers [
	^ ByteArray streamContents: [ :stream |
		aCollectionOfIntegers do: [ :each |
			stream nextPut: each ] ]
]

{ #category : 'private' }
GRUtf8CodecTest >> asString: aCollectionOfIntegers [
	^ String streamContents: [ :stream |
		aCollectionOfIntegers do: [ :each |
			stream nextPut: (Character codePoint: each) ] ]
]

{ #category : 'accessing' }
GRUtf8CodecTest >> decodedString [
	^ 'Übèrstrîñgé'
]

{ #category : 'private' }
GRUtf8CodecTest >> seasideByteArray [
	^ #(83 101 97 115 105 100 101) "Seaside" asByteArray
]

{ #category : 'tests' }
GRUtf8CodecTest >> testCodecUtf8 [
	#('UTF-8' 'utf-8') do: [ :codecName |
		| codec |
		codec := GRCodec forEncoding: codecName.
		self assert: codec name asLowercase = codecName asLowercase.
		self assert: codec url name asLowercase = codecName asLowercase.
		self assert: (codec encode: self decodedString) = (self utf8StringOrByteArrayForCodec: codec).
		self assert: (codec url encode: self decodedString) = (self utf8StringOrByteArrayForCodec: codec).
		self assert: (codec decode: (self utf8StringOrByteArrayForCodec: codec)) = self decodedString.
		self assert: (codec url decode: (self utf8StringOrByteArrayForCodec: codec)) = self decodedString ]
]

{ #category : 'tests' }
GRUtf8CodecTest >> testCodecUtf8Bom [
	#('UTF-8' 'utf-8') do: [ :codecName |
		| codec bom |
		codec := GRCodec forEncoding: codecName.
		(codec encodedStringClass == ByteArray)
			ifTrue:[ bom := self asByteArray: #(239 187 191) ]
			ifFalse:[bom := self asString: #(239 187 191) ].
		self assert: (codec decode: bom , (self utf8StringOrByteArrayForCodec: codec)) = self decodedString.
		self assert: (codec url decode: bom , (self utf8StringOrByteArrayForCodec: codec)) = self decodedString ]
]

{ #category : 'tests' }
GRUtf8CodecTest >> testCodecUtf8BorderLineString [
	#('UTF-8' 'utf-8') do: [ :codecName |
		| codec writeStream |
		codec := GRCodec forEncoding: codecName.
		writeStream := codec encoderFor: (GRPlatform current writeCharacterStreamOn: codec encodedStringClass new).
		writeStream nextPut: (Character codePoint: 0).
		writeStream nextPut: (Character codePoint: 255).
		writeStream nextPut: (Character codePoint: 256).
		self assert: writeStream contents asString = (String
			with: (Character codePoint: 16r00) "character 0" 
			with: (Character codePoint: 16rC3) with: (Character codePoint: 16rBF) "character 255" 
			with: (Character codePoint: 16rC4) with: (Character codePoint: 16r80)) "character 256"  ]
]

{ #category : 'tests' }
GRUtf8CodecTest >> testCodecUtf8ShortestForm [
	"Non shortest form characters should be rejected
	See Corrigendum #1: UTF-8 Shortest Form http://www.unicode.org/versions/corrigendum1.html"
	#('UTF-8' 'utf-8') do: [ :codecName |
		| codec abc |
		codec := GRCodec forEncoding: codecName.
		codec encodedStringClass == ByteArray
			ifTrue:[ abc := self asByteArray: #(193 129 193 130 193 131 ) ]
			ifFalse:[ abc := self asString: #(193 129 193 130 193 131 ) ].
		self
			should: [ self deny: (codec decode: abc) = 'ABC' ]
			raise: Error ]
]

{ #category : 'tests' }
GRUtf8CodecTest >> testNext [
	| stream |
	stream := (GRCodec forEncoding: 'utf8')
		encoderFor: self seasideByteArray readStream.
	self assert: stream next = $S.
	self assert: (stream next: 1) = 'e'
]

{ #category : 'accessing' }
GRUtf8CodecTest >> utf8String [
	^ self asString: #(195 156 98 195 168 114 115 116 114 195 174 195 177 103 195 169)
]

{ #category : 'accessing' }
GRUtf8CodecTest >> utf8StringOrByteArrayForCodec: codec [
	| bytes |
	bytes := #(195 156 98 195 168 114 115 116 114 195 174 195 177 103 195 169).
	^ codec encodedStringClass == ByteArray
		ifTrue:[ self asByteArray: bytes ]
		ifFalse:[ self asString: bytes ]
]
