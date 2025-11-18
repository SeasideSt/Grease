Extension { #name : 'BinaryFloat' }

{ #category : '*grease-gemstone-core' }
BinaryFloat >> greaseString [

	| strm |
	strm := WriteStream on: String new.
	self printOn: strm base: 10.
	^strm contents
]
