Class {
	#name : 'GRTextOrBinaryCodecStream',
	#superclass : 'GRCodecStream',
	#instVars : [
		'binary'
	],
	#category : 'Grease-GemStone-Core',
	#package : 'Grease-GemStone-Core'
}

{ #category : 'actions' }
GRTextOrBinaryCodecStream >> binary [
	"switches the receiver into binary mode in which no encoding appends and arguments are expected to be binary (bytes or byte arrays)."
	binary := true
]

{ #category : 'accessing' }
GRTextOrBinaryCodecStream >> contents [
	^ stream contents
]

{ #category : 'actions' }
GRTextOrBinaryCodecStream >> flush [
	stream flush
]

{ #category : 'initialization' }
GRTextOrBinaryCodecStream >> initializeOn: aStream [
	super initializeOn: aStream.
	binary := false
]

{ #category : 'streaming' }
GRTextOrBinaryCodecStream >> next [
	^ (self next: 1) first
]

{ #category : 'streaming' }
GRTextOrBinaryCodecStream >> next: anInteger [
	| writeStream |
	writeStream := WriteStream on: String new.
	anInteger timesRepeat: [
		stream atEnd ifTrue: [ ^ writeStream contents ].
		writeStream nextPut: stream next asCharacter ].
	^ writeStream contents
]

{ #category : 'streaming' }
GRTextOrBinaryCodecStream >> nextPut: aCharacter [
	self nextPutAll: (String with: aCharacter)
]

{ #category : 'streaming' }
GRTextOrBinaryCodecStream >> nextPutAll: aString [
	binary
		ifTrue: [ stream nextPutAll: aString asString ]
		ifFalse: [ stream nextPutAll: aString ]
]

{ #category : 'accessing' }
GRTextOrBinaryCodecStream >> size [
	^ stream size
]

{ #category : 'actions' }
GRTextOrBinaryCodecStream >> text [
	"switches the receiver into text mode in which encoding appends and arguments are expected to be text (characters or strings)."
	binary := false
]
