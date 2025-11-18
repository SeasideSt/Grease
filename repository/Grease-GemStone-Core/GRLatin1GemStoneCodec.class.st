Class {
	#name : 'GRLatin1GemStoneCodec',
	#superclass : 'GRCodec',
	#instVars : [
		'name'
	],
	#category : 'Grease-GemStone-Core',
	#package : 'Grease-GemStone-Core'
}

{ #category : 'instance-creation' }
GRLatin1GemStoneCodec class >> basicForEncoding: aString [

	(self supportsEncoding: aString)
		ifFalse: [ ^ self unsupportedEncoding: aString ].
	^(self new)
		name: aString;
		yourself
]

{ #category : 'accessing' }
GRLatin1GemStoneCodec class >> codecs [
  ^ Array with: self new
]

{ #category : 'testing' }
GRLatin1GemStoneCodec class >> supportsEncoding: aString [
	"Answer whether the the given encoding name is supported."

	^ #('iso-8859-1' 'ISO-8859-1' 'latin-1' 'latin1') includes: aString
]

{ #category : 'decoding' }
GRLatin1GemStoneCodec >> decode: aByteString [
	^aByteString asString
]

{ #category : 'encoding' }
GRLatin1GemStoneCodec >> encode: aByteString [
	^aByteString asString
]

{ #category : 'encoding' }
GRLatin1GemStoneCodec >> encodeUrl: aString [
	^aString
]

{ #category : 'conversion' }
GRLatin1GemStoneCodec >> encoderFor: aWriteStream [

	^ GRTextOrBinaryCodecStream on: aWriteStream
]

{ #category : 'accessing' }
GRLatin1GemStoneCodec >> name [
	^ name
]

{ #category : 'accessing' }
GRLatin1GemStoneCodec >> name: aString [

	name := aString
]

{ #category : 'accessing' }
GRLatin1GemStoneCodec >> url [

	^self
]
