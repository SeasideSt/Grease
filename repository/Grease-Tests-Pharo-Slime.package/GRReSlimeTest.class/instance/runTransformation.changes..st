running-checks
runTransformation: aClass changes: aCollection

	| expected |
	expected := aCollection collect: [ :each | RBParser parseMethod: each ].
	self run: aClass ignoring: Array new do: [ :critiques | | changes |
		changes := critiques collect:[ :critique | critique change ].
		changes do: [ :change |
			self
				assert: (expected anySatisfy: [ :parseTree | change parseTree = parseTree ])
				description: ('{1} should not be transformed' format: { change selector }) ].
		expected do: [ :parseTree |
			self
				assert: (changes anySatisfy: [ :change | change parseTree = parseTree ])
				description: ('{1} should be transformed' format: { parseTree selector }) ] ]