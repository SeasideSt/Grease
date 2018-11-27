enumerating
noneSatisfy: aOneArgumentBlock
	size = 0 ifTrue: [ ^ true ].
	2 to: size * 2 by: 2 do: [ :index |
		(aOneArgumentBlock value: (table at: index)) ifTrue: [ ^ false ] ].
	^ true