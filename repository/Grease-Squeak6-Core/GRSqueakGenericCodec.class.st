Class {
	#name : 'GRSqueakGenericCodec',
	#superclass : 'GRCodec',
	#instVars : [
		'name',
		'urlCodec'
	],
	#category : 'Grease-Squeak6-Core',
	#package : 'Grease-Squeak6-Core'
}

{ #category : 'private' }
GRSqueakGenericCodec class >> basicForEncoding: aString [
	(self supportsEncoding: aString)
		ifFalse: [ self unsupportedEncoding: aString ].
	^ self basicNew initializeWithName: aString
]

{ #category : 'accessing' }
GRSqueakGenericCodec class >> codecs [
	^ (TextConverter allEncodingNames
		select:  [ :each | 
			"exclude UFT-8 which is handled by WAUtf8Codec"
			self supportsEncoding: each ])
		collect: [ :each |
			self basicForEncoding: each greaseString ]
]

{ #category : 'private' }
GRSqueakGenericCodec class >> supportedEncodingNames [
	"answers the names of the encodings supported by this class"

	^ (TextConverter allSubclasses gather: [ :class | class encodingNames ]) asSet asOrderedCollection
		removeAllFoundIn: GRSqueakLatin1Codec supportedEncodingNames;
		removeAllFoundIn: UTF8TextConverter encodingNames;
		yourself
]

{ #category : 'testing' }
GRSqueakGenericCodec class >> supportsEncoding: aString [
	"Answer whether the the given encoding name is supported."
	^ self supportedEncodingNames includes: aString
]

{ #category : 'private' }
GRSqueakGenericCodec >> converter [
	^ TextConverter newForEncoding: self name
]

{ #category : 'conversion' }
GRSqueakGenericCodec >> decoderFor: aStream [
	^ self encoderFor: aStream
]

{ #category : 'conversion' }
GRSqueakGenericCodec >> encoderFor: aStream [ 
	^ GRSqueakConverterCodecStream 
		on: aStream
		converter: self converter
]

{ #category : 'initialization' }
GRSqueakGenericCodec >> initializeWithName: aString [ 
	self initialize.
	name := aString.
	urlCodec := (#('iso-8859-15' 'cp-1252') includes: aString) 
		ifFalse: [ GRCodec forEncoding: 'utf-8' ]
		ifTrue: [ self ]
]

{ #category : 'accessing' }
GRSqueakGenericCodec >> name [
	^ name
]

{ #category : 'accessing' }
GRSqueakGenericCodec >> url [
	"RFC 3986: When a new URI scheme defines a component that represents textual data consisting of characters from the Universal Character Set [UCS], the data should first be encoded as octets according to the UTF-8 character encoding."

	^ urlCodec
]
