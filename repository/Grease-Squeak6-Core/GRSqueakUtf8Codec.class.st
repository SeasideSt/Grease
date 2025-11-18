"
A WAUtf8Codec is a WACodec optimized for UTF-8.
"
Class {
	#name : 'GRSqueakUtf8Codec',
	#superclass : 'GRCodec',
	#category : 'Grease-Squeak6-Core',
	#package : 'Grease-Squeak6-Core'
}

{ #category : 'private' }
GRSqueakUtf8Codec class >> basicForEncoding: aString [
	^ self new
]

{ #category : 'accessing' }
GRSqueakUtf8Codec class >> codecs [
	^ Array with: self new
]

{ #category : 'testing' }
GRSqueakUtf8Codec class >> supportsEncoding: aString [
	^ (#('utf-8' 'UTF-8') includes: aString) or: [ UTF8TextConverter encodingNames includes: aString ]
]

{ #category : 'decoding' }
GRSqueakUtf8Codec >> decode: aString [
	"Convert the given string from UTF-8 using the fast path if converting to Latin-1"
	| outStream byte1 byte2 byte3 byte4 unicode stream |
	stream := aString readStream.
	outStream := WriteStream on: (String new: aString size).
	[ stream atEnd not ] whileTrue: [
		byte1 := stream next asInteger.
		unicode := byte1.
		(byte1 bitAnd: 16rE0) = 192 ifTrue: [ "two bytes"
			byte2 := stream next asInteger.
			(byte2 bitAnd: 16rC0) = 16r80 ifFalse: [ self invalidUtf8 ].
			unicode := ((byte1 bitAnd: 31) bitShift: 6) + (byte2 bitAnd: 63) ].
		(byte1 bitAnd: 16rF0) = 224 ifTrue: [ "three bytes"
			byte2 := stream next asInteger.
			(byte2 bitAnd: 16rC0) = 16r80 ifFalse: [ self invalidUtf8 ].
			byte3 := stream next asInteger.
			(byte3 bitAnd: 16rC0) = 16r80 ifFalse: [ self invalidUtf8 ].
			unicode := ((byte1 bitAnd: 15) bitShift: 12) + ((byte2 bitAnd: 63) bitShift: 6)
				+ (byte3 bitAnd: 63) ].
		(byte1 bitAnd: 16rF8) = 240 ifTrue: [ "four bytes"
			byte2 := stream next asInteger.
			(byte2 bitAnd: 16rC0) = 16r80 ifFalse: [ self invalidUtf8 ].
			byte3 := stream next asInteger.
			(byte3 bitAnd: 16rC0) = 16r80 ifFalse: [ self invalidUtf8 ].
			byte4 := stream next asInteger.
			(byte4 bitAnd: 16rC0) = 16r80 ifFalse: [ self invalidUtf8 ].
			unicode := ((byte1 bitAnd: 16r7) bitShift: 18) +
							((byte2 bitAnd: 63) bitShift: 12) + 
							((byte3 bitAnd: 63) bitShift: 6) +
							(byte4 bitAnd: 63) ].
		unicode ifNil: [ self invalidUtf8 ].
		unicode = 16rFEFF "ignore BOM" ifFalse: [
			outStream nextPut: (Character codePoint: unicode) ].
		unicode := nil ].
	^ outStream contents
]

{ #category : 'conversion' }
GRSqueakUtf8Codec >> decoderFor: aStream [ 
	^ GRSqueakUtf8CodecStream 
		on: aStream
		converter: UTF8TextConverter new
]

{ #category : 'conversion' }
GRSqueakUtf8Codec >> encoderFor: aStream [ 
	^ GRSqueakUtf8CodecStream 
		on: aStream
		converter: UTF8TextConverter new
]

{ #category : 'private' }
GRSqueakUtf8Codec >> invalidUtf8 [
	^ GRInvalidUtf8Error signal: 'Invalid UTF-8 input'
]

{ #category : 'accessing' }
GRSqueakUtf8Codec >> name [
	^ 'utf-8'
]

{ #category : 'accessing' }
GRSqueakUtf8Codec >> url [
	^ self
]
