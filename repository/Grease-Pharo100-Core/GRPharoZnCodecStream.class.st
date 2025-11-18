Class {
	#name : 'GRPharoZnCodecStream',
	#superclass : 'GRCodecStream',
	#instVars : [
		'encoder'
	],
	#category : 'Grease-Pharo100-Core',
	#package : 'Grease-Pharo100-Core'
}

{ #category : 'instance creation' }
GRPharoZnCodecStream class >> on: aStream withEncoder: aZnEncoder [
	^ self basicNew initializeOn: aStream withEncoder: aZnEncoder
]

{ #category : 'accessing' }
GRPharoZnCodecStream >> greaseNext: anInteger putAll: aCollection startingAt: startIndex [
	encoder next: anInteger putAll: aCollection startingAt: startIndex toStream: stream
]

{ #category : 'initialization' }
GRPharoZnCodecStream >> initializeOn: aStream withEncoder: aZnEncoder [
	self initialize.
	stream := aStream.
	encoder := aZnEncoder
]

{ #category : 'accessing' }
GRPharoZnCodecStream >> next [
	| character |
	stream atEnd ifTrue: [ ^ nil ].
	character := encoder nextFromStream: stream.
	^ character ifNotNil: [ character asCharacter ]
]

{ #category : 'accessing' }
GRPharoZnCodecStream >> next: anInteger [
	| writeStream |
	writeStream := WriteStream on: (String new: anInteger).
	anInteger timesRepeat: [
		writeStream nextPut: (self next
			ifNil: [ ^ writeStream contents ]) ].
	^ writeStream contents
]

{ #category : 'accessing' }
GRPharoZnCodecStream >> nextPut: aCharacter [
	encoder nextPut: aCharacter asCharacter toStream: stream
]

{ #category : 'streaming' }
GRPharoZnCodecStream >> nextPutAll: aString [
	| string |
	string := aString asString.
	encoder next: string size putAll: string startingAt: 1 toStream: stream
]
