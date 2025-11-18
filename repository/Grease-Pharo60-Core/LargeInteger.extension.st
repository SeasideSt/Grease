Extension { #name : 'LargeInteger' }

{ #category : '*Grease-Pharo60-Core' }
LargeInteger >> greaseByteAt: index [
	"Primitive. Answer the value of an indexable field in the receiver.   LargePositiveInteger uses bytes of base two number, and each is a 'digit' base 256.  Fail if the argument (the index) is not an Integer or is out of bounds. Essential.  See Object documentation whatIsAPrimitive."

	<primitive: 60>
	self greaseBytesCount < index
		ifTrue: [^0]
		ifFalse: [^super at: index]
]

{ #category : '*Grease-Pharo60-Core' }
LargeInteger >> greaseBytesCount [
	"Primitive. Answer the number of indexable fields in the receiver. This 
	value is the same as the largest legal subscript. Essential. See Object 
	documentation whatIsAPrimitive."

	<primitive: 62>
	self primitiveFailed
]
