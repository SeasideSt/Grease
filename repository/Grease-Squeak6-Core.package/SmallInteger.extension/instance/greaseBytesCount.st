*Grease-Squeak6-Core
greaseBytesCount
	"Answer the number of indexable fields in the receiver. This value is the 
	 same as the largest legal subscript. Included so that a SmallInteger can 
	 behave like a LargePositiveInteger or LargeNegativeInteger."
	
	"32768 == (1 bitShift: 15)"
	"32768 bytesCount >>> 2"
	
	"65536 == (1 bitShift: 16)"
	"65536 bytesCount >>> 3"
	
	| value length |
	length := 1.
	value := self.
	value >= 0
		ifTrue:
			[[value > 255] whileTrue:
				[value := value bitShift: -8.
				 length := length + 1]]
		ifFalse:
			[[value < -255] whileTrue:
				[value := value bitShift: -8.
				 length := length + 1]].
	^length