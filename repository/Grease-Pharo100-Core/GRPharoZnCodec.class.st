Class {
	#name : 'GRPharoZnCodec',
	#superclass : 'GRCodec',
	#instVars : [
		'name',
		'urlCodec'
	],
	#category : 'Grease-Pharo100-Core',
	#package : 'Grease-Pharo100-Core'
}

{ #category : 'private' }
GRPharoZnCodec class >> basicForEncoding: aString [
	(self supportsEncoding: aString)
		ifFalse: [ self unsupportedEncoding: aString ].
	^ self basicNew initializeWithName: aString
]

{ #category : 'accessing' }
GRPharoZnCodec class >> codecs [
	^ self supportedEncodingNames
		collect: [ :each | self basicForEncoding: each greaseString ]
]

{ #category : 'accessing' }
GRPharoZnCodec class >> supportedEncodingNames [
	"answers the names of the encodings supported by this class"

	| all |
	all := ZnCharacterEncoder knownEncodingIdentifiers asOrderedCollection.
	"We include some (but not all) alternative names for encodings, providing some backwards compatibility with TextConverter encoding names. Make a PR if you need more."
	(all includes: 'utf8')
		ifTrue:[ all addAll: #('utf-8' 'UTF-8') ].
	(all includes: 'utf16')
		ifTrue:[ all addAll: #('utf-16' 'UTF-16') ].
	(all includes: 'macroman')
		ifTrue:[ all add: 'mac-roman' ].
	(all includes: 'cp1252')
		ifTrue:[ all add: 'cp-1252' ].
	^ all
]

{ #category : 'accessing' }
GRPharoZnCodec class >> supportsEncoding: aName [
	^ self supportedEncodingNames includes: aName
]

{ #category : 'convenience' }
GRPharoZnCodec >> decode: aStringOrByteArray [
	^ super decode: aStringOrByteArray asByteArray
]

{ #category : 'conversion' }
GRPharoZnCodec >> decoderFor: aStream [
	^ self encoderFor: aStream
]

{ #category : 'conversion' }
GRPharoZnCodec >> encodedStringClass [
	^ ByteArray
]

{ #category : 'conversion' }
GRPharoZnCodec >> encoderFor: aStream [
	^ GRPharoZnCodecStream
		on: aStream
		withEncoder: (ZnCharacterEncoder newForEncoding: self name)
]

{ #category : 'initialization' }
GRPharoZnCodec >> initializeWithName: aString [
	self initialize.
	name := aString.
	urlCodec := (#('iso-8859-15' 'cp-1252' 'utf8' 'utf-8' 'UTF-8') includes: aString)
		ifFalse: [ GRCodec forEncoding: 'utf8' ]
		ifTrue: [ self ]
]

{ #category : 'accessing' }
GRPharoZnCodec >> name [
	^ name
]

{ #category : 'accessing' }
GRPharoZnCodec >> url [
	"RFC 3986: When a new URI scheme defines a component that represents textual data consisting of characters from the Universal Character Set [UCS], the data should first be encoded as octets according to the UTF-8 character encoding."

	^ urlCodec
]
