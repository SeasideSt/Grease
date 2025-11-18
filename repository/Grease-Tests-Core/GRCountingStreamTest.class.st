Class {
	#name : 'GRCountingStreamTest',
	#superclass : 'TestCase',
	#instVars : [
		'countingStream'
	],
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'running' }
GRCountingStreamTest >> setUp [
	| codecStream |
	codecStream := ((GRCodec forEncoding: 'utf-8') encoderFor: (WriteStream on: (GRCodec forEncoding: 'utf-8') encodedStringClass new)).
	countingStream := GRCountingStream on: codecStream
]

{ #category : 'testing' }
GRCountingStreamTest >> testInitialSize [
	self assert: countingStream count = 0
]

{ #category : 'testing' }
GRCountingStreamTest >> testNextPut [
	countingStream nextPut: (Character codePoint: 16rE4).
	self assert: countingStream size = 2.
	self assert: countingStream count = 1.
	self assert: countingStream contents asString = (String with: (Character codePoint: 16rC3) with: (Character codePoint: 16rA4))
]

{ #category : 'testing' }
GRCountingStreamTest >> testNextPutAll [
	countingStream nextPutAll: (String with: (Character codePoint: 16rE4)).
	self assert: countingStream size = 2.
	self assert: countingStream count = 1.
	self assert: countingStream contents asString = (String with: (Character codePoint: 16rC3) with: (Character codePoint: 16rA4))
]

{ #category : 'testing' }
GRCountingStreamTest >> testReset [
	countingStream nextPut: $a.
	self assert: countingStream count = 1.
	countingStream reset.
	self assert: countingStream count = 0
]
