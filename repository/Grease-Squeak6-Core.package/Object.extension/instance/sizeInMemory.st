*grease-squeak6-core
sizeInMemory
	"Answer the number of bytes consumed by this instance including object header."

	^ [ self class isVariable 
		ifTrue: [ self class byteSizeOfInstanceOfSize: self basicSize]
		ifFalse: [ self class byteSizeOfInstance]
		"Some classes count them no size (SmallInteger, Character..), so this fails" 
	] on: Error do: [0].