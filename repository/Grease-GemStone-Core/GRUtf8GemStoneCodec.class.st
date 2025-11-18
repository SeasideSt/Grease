Class {
	#name : 'GRUtf8GemStoneCodec',
	#superclass : 'GRCodec',
	#instVars : [
		'implementation'
	],
	#category : 'Grease-GemStone-Core',
	#package : 'Grease-GemStone-Core'
}

{ #category : 'instance-creation' }
GRUtf8GemStoneCodec class >> basicForEncoding: aString [

	(self supportsEncoding: aString)
		ifFalse: [ ^ self unsupportedEncoding: aString ].
	^self new
]

{ #category : 'accessing' }
GRUtf8GemStoneCodec class >> codecs [
  ^ Array with: self new
]

{ #category : 'testing' }
GRUtf8GemStoneCodec class >> supportsEncoding: aString [
	"Answer whether the the given encoding name is supported."

	^ #( 'utf-8' 'UTF-8' 'utf8' 'UTF8' ) includes: aString
]

{ #category : 'decoding' }
GRUtf8GemStoneCodec >> decode: aByteString [

	^implementation decode: aByteString asString.
]

{ #category : 'conversion' }
GRUtf8GemStoneCodec >> decoderFor: aWriteStream [

	^ GRUtf8CodecStream on: aWriteStream
]

{ #category : 'encoding' }
GRUtf8GemStoneCodec >> encode: aByteString [

	^(implementation encode: aByteString) asString
]

{ #category : 'encoding' }
GRUtf8GemStoneCodec >> encodeUrl: aByteString [

	^(implementation encode: aByteString) asString
]

{ #category : 'conversion' }
GRUtf8GemStoneCodec >> encoderFor: aWriteStream [

	^ GRUtf8CodecStream on: aWriteStream
]

{ #category : 'initialize' }
GRUtf8GemStoneCodec >> initialize [

	super initialize.
	implementation := UTF8Encoding newEncoder.
]

{ #category : 'accessing' }
GRUtf8GemStoneCodec >> name [
	^ 'utf-8'
]

{ #category : 'accessing' }
GRUtf8GemStoneCodec >> url [

		^self
]
