Class {
	#name : 'GRPharoZnUtf8CodecStream',
	#superclass : 'GRCodecStream',
	#instVars : [
		'encoder'
	],
	#category : 'Grease-Pharo90-Core',
	#package : 'Grease-Pharo90-Core'
}

{ #category : 'accessing' }
GRPharoZnUtf8CodecStream >> greaseNext: anInteger putAll: aCollection startingAt: startIndex [
	encoder next: anInteger putAll: aCollection startingAt: startIndex toStream: stream 
]

{ #category : 'initialization' }
GRPharoZnUtf8CodecStream >> initializeOn: aStream [
	super initializeOn: aStream.
	encoder := ZnCharacterEncoder utf8
]

{ #category : 'accessing' }
GRPharoZnUtf8CodecStream >> next [
	| character |
	stream atEnd ifTrue: [ ^ nil ].
	character := encoder nextFromStream: stream.
	^ character ifNotNil: [ character asCharacter ]
]

{ #category : 'accessing' }
GRPharoZnUtf8CodecStream >> next: anInteger [
	| writeStream |
	writeStream := WriteStream on: (String new: anInteger).
	anInteger timesRepeat: [
		writeStream nextPut: (self next
			ifNil: [ ^ writeStream contents ]) ].
	^ writeStream contents
]

{ #category : 'accessing' }
GRPharoZnUtf8CodecStream >> nextPut: aCharacter [
	encoder nextPut: aCharacter asCharacter toStream: stream
]

{ #category : 'streaming' }
GRPharoZnUtf8CodecStream >> nextPutAll: aString [
	| string |
	string := aString asString.
	encoder next: string size putAll: string startingAt: 1 toStream: stream 
]
