Class {
	#name : 'GRUtf8CodecStream',
	#superclass : 'GRTextOrBinaryCodecStream',
	#category : 'Grease-GemStone200-Core',
	#package : 'Grease-GemStone200-Core'
}

{ #category : 'streaming' }
GRUtf8CodecStream >> crlf [
	binary
		ifTrue: [
			stream nextPut: 13.
			stream nextPut: 10 ]
		ifFalse: [
			stream nextPut: Character cr.
			stream nextPut: Character lf ]
]

{ #category : 'private' }
GRUtf8CodecStream >> invalidUtf8 [
	^GRInvalidUtf8Error signal: 'Invalid UTF-8 input'
]

{ #category : 'streaming' }
GRUtf8CodecStream >> next: anInteger [
	"Convert the given string from UTF-8 using the fast path if converting to Latin-1"
	| outStream byte1 byte2 byte3 byte4 unicode count |
	outStream := WriteStream on: (String new: anInteger).
	count := 0.
	[ count < anInteger and: [ stream atEnd not ] ] whileTrue: [
		byte1 := stream next.
		unicode := byte1.
		(byte1 bitAnd: 16rE0) = 192 ifTrue: [ "two bytes"
			byte2 := stream next.
			(byte2 bitAnd: 16rC0) = 16r80 ifFalse: [ self invalidUtf8 ].
			unicode := ((byte1 bitAnd: 31) bitShift: 6) + (byte2 bitAnd: 63)].
		(byte1 bitAnd: 16rF0) = 224 ifTrue: [ "three bytes"
			byte2 := stream next.
			(byte2 bitAnd: 16rC0) = 16r80 ifFalse: [ self invalidUtf8 ].
			byte3 := stream next.
			(byte3 bitAnd: 16rC0) = 16r80 ifFalse: [ self invalidUtf8 ].
			unicode := ((byte1 bitAnd: 15) bitShift: 12) + ((byte2 bitAnd: 63) bitShift: 6)
				+ (byte3 bitAnd: 63)].
		(byte1 bitAnd: 16rF8) = 240 ifTrue: [ "four bytes"
			byte2 := stream next.
			(byte2 bitAnd: 16rC0) = 16r80 ifFalse: [ self invalidUtf8 ].
			byte3 := stream next.
			(byte3 bitAnd: 16rC0) = 16r80 ifFalse: [ self invalidUtf8 ].
			byte4 := stream next.
			(byte4 bitAnd: 16rC0) = 16r80 ifFalse: [ self invalidUtf8 ].
			unicode := ((byte1 bitAnd: 16r7) bitShift: 18) +
							((byte2 bitAnd: 63) bitShift: 12) + 
							((byte3 bitAnd: 63) bitShift: 6) +
							(byte4 bitAnd: 63)].
		unicode ifNil: [ self invalidUtf8 ].
		unicode = 16rFEFF "ignore BOM" ifFalse: [
			outStream nextPut: (Character codePoint: unicode).
			count := count + 1 ].
		unicode := nil ].
	^outStream contents
]

{ #category : 'streaming' }
GRUtf8CodecStream >> nextPut: aCharacter [
	self nextPutAll: (String with: aCharacter)
]

{ #category : 'streaming' }
GRUtf8CodecStream >> nextPutAll: aString [
	binary
		ifTrue: [ stream nextPutAll: aString asString ]
		ifFalse: [ stream nextPutAll: aString encodeAsUTF8 asString ]
]
