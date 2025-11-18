Extension { #name : 'SmallInteger' }

{ #category : '*Grease-Pharo60-Core' }
SmallInteger >> greaseByteAt: n [
	"Answer the value of an apparent byte-indexable field in the receiver,
	 analogous to the large integers, which are organized as bytes."

	n = 1
		ifTrue: [ 
			"Negate carefully in case the receiver is SmallInteger minVal"
			^ self < 0
				ifTrue: [ -256 - self bitAnd: 255 ]
				ifFalse: [ self bitAnd: 255 ] ].
	^ self < 0
		ifTrue: [ (-256 - self bitShift: -8) + 1 byteAt: n - 1 ]
		ifFalse: [ (self bitShift: 8 - (n bitShift: 3)) bitAnd: 255 ]
]

{ #category : '*Grease-Pharo60-Core' }
SmallInteger >> greaseBytesCount [
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
]
