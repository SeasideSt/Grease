"
A GRPharoLatin1Codec is a WACodec optimized for ISO-8859-1 (direct byte to character mapping).
"
Class {
	#name : 'GRSqueakLatin1Codec',
	#superclass : 'GRNullCodec',
	#instVars : [
		'name'
	],
	#category : 'Grease-Squeak6-Core',
	#package : 'Grease-Squeak6-Core'
}

{ #category : 'private' }
GRSqueakLatin1Codec class >> basicForEncoding: aString [
	(self supportsEncoding: aString)
		ifFalse: [ self unsupportedEncoding: aString ].
	^ self basicNew initializeWithName: aString
]

{ #category : 'accessing' }
GRSqueakLatin1Codec class >> codecs [
	^ Array with: (self basicForEncoding: 'iso-8859-1')
]

{ #category : 'private' }
GRSqueakLatin1Codec class >> supportedEncodingNames [
	^ #('iso-8859-1' 'ISO-8859-1' 'latin-1' 'latin1')
]

{ #category : 'testing' }
GRSqueakLatin1Codec class >> supportsEncoding: aString [
	"Answer whether the the given encoding name is supported."
	^ self supportedEncodingNames includes: aString
]

{ #category : 'conversion' }
GRSqueakLatin1Codec >> decode: aStringOrByteArray [
	"Overridden for efficiency."

	^ aStringOrByteArray asString
]

{ #category : 'conversion' }
GRSqueakLatin1Codec >> decoderFor: aReadStream [ 
	"wrap to avoid String vs ByteArray issues"
	^ GRSqueakLatin1CodecStream on: aReadStream
]

{ #category : 'conversion' }
GRSqueakLatin1Codec >> encoderFor: aWriteStream [ 
	"wrap to avoid String vs ByteArray issues"
	^ GRSqueakLatin1CodecStream on: aWriteStream
]

{ #category : 'initialization' }
GRSqueakLatin1Codec >> initializeWithName: aString [ 
	self initialize.
	name := aString
]

{ #category : 'accessing' }
GRSqueakLatin1Codec >> name [
	^ name
]
