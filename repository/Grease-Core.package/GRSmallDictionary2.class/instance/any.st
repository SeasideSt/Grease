accessing
any
	self isEmpty
		ifTrue: [ ^ self errorEmptyCollection ].
	^ table at: 2