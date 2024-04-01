running
expectedFailures

	SystemVersion current major >= 12 ifTrue:[ ^ #() ].
	
	^ #(#testEmptyStatements)