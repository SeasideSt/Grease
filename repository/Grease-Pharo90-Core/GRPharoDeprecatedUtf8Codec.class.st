Class {
	#name : 'GRPharoDeprecatedUtf8Codec',
	#superclass : 'GRCodec',
	#category : 'Grease-Pharo90-Core',
	#package : 'Grease-Pharo90-Core'
}

{ #category : 'private' }
GRPharoDeprecatedUtf8Codec class >> basicForEncoding: aString [
	^ self new
]

{ #category : 'accessing' }
GRPharoDeprecatedUtf8Codec class >> codecs [
	^ GRPlatform current utf8CodecClass == self
		ifTrue:[ Array with: self new ]
		ifFalse: [ Array new ]
]

{ #category : 'testing' }
GRPharoDeprecatedUtf8Codec class >> supportsEncoding: aString [
	^ GRPlatform current utf8CodecClass == self and: [(#('utf-8' 'UTF-8') includes: aString) or: [ UTF8TextConverter encodingNames includes: aString ] ]
]

{ #category : 'convenience' }
GRPharoDeprecatedUtf8Codec >> decode: aString [
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

{ #category : 'convenience' }
GRPharoDeprecatedUtf8Codec >> decoderFor: aStream [ 
	^ GRPharoDeprecatedUtf8CodecStream 
		on: aStream
		converter: UTF8TextConverter new
]

{ #category : 'conversion' }
GRPharoDeprecatedUtf8Codec >> encodedStringClass [
	^ String
]

{ #category : 'convenience' }
GRPharoDeprecatedUtf8Codec >> encoderFor: aStream [ 
	^ GRPharoDeprecatedUtf8CodecStream 
		on: aStream
		converter: UTF8TextConverter new
]

{ #category : 'convenience' }
GRPharoDeprecatedUtf8Codec >> invalidUtf8 [
	^ GRInvalidUtf8Error signal: 'Invalid UTF-8 input'
]

{ #category : 'accessing' }
GRPharoDeprecatedUtf8Codec >> name [
	^ 'utf-8'
]

{ #category : 'accessing' }
GRPharoDeprecatedUtf8Codec >> url [
	^ self
]
