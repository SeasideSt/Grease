running-checks
assertRule: aRuleClass expectedMatches: aCollectionOfExpectedEntities ignoring: aCollectionOfIgnoredEntities

	self run: aRuleClass ignoring: aCollectionOfIgnoredEntities do: [ :critiques | | critiquedEntities |
		critiquedEntities := critiques collect:[ :critique | critique sourceAnchor entity ].
		critiquedEntities do:[ :critiquedEntity |
			self
				assert: (aCollectionOfExpectedEntities includes: critiquedEntity)
				description: critiquedEntity printString , ' should not be reported' ].
		aCollectionOfExpectedEntities do: [ :expectedEntity |
			self
				assert: (critiquedEntities includes: expectedEntity)
				description: expectedEntity printString , ' should be reported' ] ]