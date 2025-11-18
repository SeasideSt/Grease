"
A GRPharoLatin1CodecStream is a WACodecStream optimized for ISO-8859-1 (direct byte to character mapping).
"
Class {
	#name : 'GRSqueakLatin1CodecStream',
	#superclass : 'GRNullCodecStream',
	#category : 'Grease-Squeak6-Core',
	#package : 'Grease-Squeak6-Core'
}

{ #category : 'streaming' }
GRSqueakLatin1CodecStream >> next [
	^ Character codePoint: stream next
]

{ #category : 'streaming' }
GRSqueakLatin1CodecStream >> next: anInteger [
	^ (stream next: anInteger) asString
]
