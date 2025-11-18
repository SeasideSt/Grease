"
A WAUtf8Codec is a WACodec optimized for UTF-8.
"
Class {
	#name : 'GRPharoUtf8Codec',
	#superclass : 'GRCodec',
	#category : 'Grease-Pharo90-Core',
	#package : 'Grease-Pharo90-Core'
}

{ #category : 'private' }
GRPharoUtf8Codec class >> basicForEncoding: aString [
	^ self new
]

{ #category : 'accessing' }
GRPharoUtf8Codec class >> codecs [
	^ GRPlatform current utf8CodecClass == self
		ifTrue:[ Array with: self new ]
		ifFalse: [ Array new ]
]

{ #category : 'private' }
GRPharoUtf8Codec class >> supportsEncoding: aString [
	^ GRPlatform current utf8CodecClass == self and: [ (#('utf-8' 'UTF-8' 'utf8') includes: aString) ]
]

{ #category : 'convenience' }
GRPharoUtf8Codec >> decode: aStringOrByteArray [
	^ super decode: aStringOrByteArray asByteArray
]

{ #category : 'conversion' }
GRPharoUtf8Codec >> decoderFor: aStream [ 
	^ GRPharoZnUtf8CodecStream 
		on: aStream
]

{ #category : 'conversion' }
GRPharoUtf8Codec >> encodedStringClass [
	^ ByteArray
]

{ #category : 'conversion' }
GRPharoUtf8Codec >> encoderFor: aStream [ 
	^ GRPharoZnUtf8CodecStream 
		on: aStream
]

{ #category : 'private' }
GRPharoUtf8Codec >> invalidUtf8 [
	^ GRInvalidUtf8Error signal: 'Invalid UTF-8 input'
]

{ #category : 'accessing' }
GRPharoUtf8Codec >> name [
	^ 'utf-8'
]

{ #category : 'accessing' }
GRPharoUtf8Codec >> url [
	^ self
]
