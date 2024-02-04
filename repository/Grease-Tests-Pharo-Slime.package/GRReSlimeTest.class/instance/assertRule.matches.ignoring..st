running-checks
assertRule: aRuleClass matches: expectedMatches ignoring: ignoredRuleClasses

	self run: aRuleClass ignoring: ignoredRuleClasses do: [ :critiques | | critiquedEntities |
		critiquedEntities := critiques collect:[ :critique | critique sourceAnchor entity ].
		critiquedEntities do:[ :critiquedEntity |
			self
				assert: (expectedMatches includes: critiquedEntity)
				description: ('{1} should not be reported' format: { critiquedEntity printString }) ].
		expectedMatches do: [ :expectedEntity |
			self
				assert: (critiquedEntities includes: expectedEntity)
				description: ('{1} should be reported' format: { expectedEntity printString }) ] ]