enumerating
noneSatisfy: aOneArgumentBlock
	1 to: size do: [ :index |
		(aOneArgumentBlock value: (values at: index)) ifTrue: [ ^ false ] ].
	^ true