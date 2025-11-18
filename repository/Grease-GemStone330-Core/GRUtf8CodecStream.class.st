Class {
	#name : 'GRUtf8CodecStream',
	#superclass : 'GRTextOrBinaryCodecStream',
	#classVars : [
		'Latin1ToUtf8Encodings'
	],
	#category : 'Grease-GemStone330-Core',
	#package : 'Grease-GemStone330-Core'
}

{ #category : 'initialization' }
GRUtf8CodecStream class >> initialize [
  "self initialize"

  Latin1ToUtf8Encodings := Array new: 256.
  1 to: 256 do: [ :index | 
    index > 128
      ifTrue: [ 
        Latin1ToUtf8Encodings
          at: index
          put:
            (String with: (Character codePoint: index - 1)) encodeAsUTF8 asString ] ]
]

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
  "old implementation is very slow !!"

  "   self nextPutAll: (String with: aCharacter)"

  | codePoint |
  codePoint := aCharacter codePoint.
  codePoint > 127
    ifTrue: [ 
      codePoint > 255
        ifTrue: [ 
          | str |
          str := (String with: aCharacter) encodeAsUTF8intoString.
          stream nextPutAll: str ]
        ifFalse: [ stream nextPutAll: (Latin1ToUtf8Encodings at: codePoint + 1) ] ]
    ifFalse: [ stream nextPut: aCharacter ]
]

{ #category : 'streaming' }
GRUtf8CodecStream >> nextPutAll: aString [
  binary
    ifTrue: [ stream nextPutAll: aString asString ]
    ifFalse: [ stream nextPutAll: aString _encodeAsUTF8intoString ]
]
