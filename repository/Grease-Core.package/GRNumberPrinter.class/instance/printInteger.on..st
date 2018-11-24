printing
printInteger: aNumber on: aStream
	| length |
	length := self lengthOf: aNumber base: base.
	
	(digits notNil and: [ padding notNil ])
		ifTrue: [ self padLeft: padding to: (digits - length) on: aStream ].
	
	self printDigitsOf: aNumber withLength: length on: aStream