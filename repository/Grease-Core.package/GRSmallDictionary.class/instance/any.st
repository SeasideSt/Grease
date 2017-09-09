accessing
any
	self isEmpty
		ifTrue: [ ^ self errorEmptyCollection ].
	^ values at: 1