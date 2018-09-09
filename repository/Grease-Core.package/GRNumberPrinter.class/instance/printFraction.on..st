printing
printFraction: aNumber on: aStream
	| result |
	result := self
		pad: (self digitsOf: aNumber rounded base: base)
		left: $0 to: precision.
	separator isNil
		ifTrue: [ aStream nextPutAll: result ]
		ifFalse: [ self separate: result left: separator on: aStream ]