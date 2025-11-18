Class {
	#name : 'GRNullCodecStreamTest',
	#superclass : 'TestCase',
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'accessing' }
GRNullCodecStreamTest >> codecStreamClass [
	^ GRNullCodecStream
]

{ #category : 'tests-characters' }
GRNullCodecStreamTest >> testCrlf [
	| stream |
	stream := GRNullCodec new 
		encoderFor: (WriteStream on: String new).
	stream crlf.
	
	self assert: stream contents size = 2.
	self assert: stream contents first = Character cr.
	self assert: stream contents last = Character lf
]

{ #category : 'tests-protocol' }
GRNullCodecStreamTest >> testFlush [
	| stream |
	stream := GRNullCodec new 
		encoderFor: (WriteStream on: String new).
	stream nextPutAll: 'abc'.
	self shouldnt: [ stream flush ] raise: Error.
	self assert: stream contents = 'abc'
]

{ #category : 'tests-characters' }
GRNullCodecStreamTest >> testName [
	| codec |
	codec := GRNullCodec new.
	
	self assert: codec name = GRNullCodec codecName
]

{ #category : 'tests-protocol' }
GRNullCodecStreamTest >> testNext [
	| stream |
	stream := GRNullCodec new
		encoderFor: 'Seaside' readStream.
	self assert: stream next = $S.
	self assert: (stream next: 1) = 'e'
]

{ #category : 'tests-protocol' }
GRNullCodecStreamTest >> testPrint [
	| stream |
	stream := GRNullCodec new 
		encoderFor: (WriteStream on: String new).
	stream print: 123.
	self assert: stream contents = '123'
]

{ #category : 'tests' }
GRNullCodecStreamTest >> testReadString [
	| stream codecStream |
	stream := 'abc' readStream.
	codecStream := GRNullCodec new decoderFor: stream.
	self assert: codecStream next = $a.
	self assert: (codecStream next: 2) = 'bc'
]

{ #category : 'tests-protocol' }
GRNullCodecStreamTest >> testSize [
	| stream |
	stream := GRNullCodec new 
		encoderFor: (WriteStream on: String new).
	stream nextPutAll: 'abc'.
	self assert: stream size = 3.
	stream nextPut: $d.
	self assert: stream size = 4
]

{ #category : 'tests-characters' }
GRNullCodecStreamTest >> testSpace [
	| stream |
	stream := GRNullCodec new 
		encoderFor: (WriteStream on: String new).
	stream space.
	
	self assert: stream contents size = 1.
	self assert: stream contents first = Character space
]

{ #category : 'tests-characters' }
GRNullCodecStreamTest >> testTab [
	| stream |
	stream := GRNullCodec new 
		encoderFor: (WriteStream on: String new).
	stream tab.
	
	self assert: stream contents size = 1.
	self assert: stream contents first = Character tab
]

{ #category : 'tests' }
GRNullCodecStreamTest >> testWriteString [
	| stream codecStream |
	stream := WriteStream on: String new.
	codecStream := GRNullCodec new encoderFor: stream.
	codecStream
		nextPut: $A;
		nextPutAll: 'BC';
		nextPut: 68;
		nextPutAll: #(69 70 ) asByteArray.
	self assert: codecStream contents = 'ABCDEF'
]
