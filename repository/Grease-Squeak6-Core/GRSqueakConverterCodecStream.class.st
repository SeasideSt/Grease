"
A GRPharoConverterCodecStream is a WACodec stream around a TextConverter. It is always in text mode.

Instance Variables
	converter:		<TextConverter>

converter
	- the TextConverter used to do the encoding conversion

"
Class {
	#name : 'GRSqueakConverterCodecStream',
	#superclass : 'GRCodecStream',
	#instVars : [
		'converter'
	],
	#category : 'Grease-Squeak6-Core',
	#package : 'Grease-Squeak6-Core'
}

{ #category : 'instance creation' }
GRSqueakConverterCodecStream class >> on: aStream converter: aConverter [
	^ self basicNew initializeOn: aStream converter: aConverter
]

{ #category : 'streaming' }
GRSqueakConverterCodecStream >> greaseNext: anInteger putAll: aCollection startingAt: startIndex [
	self nextPutAll: (aCollection copyFrom: startIndex to: startIndex + anInteger - 1)
]

{ #category : 'initialization' }
GRSqueakConverterCodecStream >> initializeOn: aStream converter: aConverter [
	self initializeOn: aStream.
	converter := aConverter
]

{ #category : 'streaming' }
GRSqueakConverterCodecStream >> next [
	| character |
	character := converter nextFromStream: stream.
	^ character isNil
		ifFalse: [ character asCharacter ]
]

{ #category : 'streaming' }
GRSqueakConverterCodecStream >> next: anInteger [
	| writeStream |
	writeStream := WriteStream on: (String new: anInteger).
	anInteger timesRepeat: [
		writeStream nextPut: (self next
			ifNil: [ ^ writeStream contents ]) ].
	^ writeStream contents
]

{ #category : 'streaming' }
GRSqueakConverterCodecStream >> nextPut: aCharacter [
	converter nextPut: aCharacter asCharacter toStream: stream
]

{ #category : 'streaming' }
GRSqueakConverterCodecStream >> nextPutAll: aString [
	aString asString do: [ :each | self nextPut: each ]
]
