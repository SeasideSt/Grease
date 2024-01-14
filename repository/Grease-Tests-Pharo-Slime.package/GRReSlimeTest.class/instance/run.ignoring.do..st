running-checks
run: aRuleClass ignoring: ignoredRuleClasses do: aBlock

	| rules rule runner |
	rules := self rules
		collect: [ :each | each new ].
	rule := rules
		detect: [ :each | each isKindOf: aRuleClass ]
		ifNone: [ self error: ('{1} is not a slime rule' format: { aRuleClass name }) ].
	self
		assert: (rule name isString and: [ rule name notEmpty ])
		description: aRuleClass name , ' has no name'.
	self
		assert: (rule rationale isString and: [ rule rationale notEmpty and: [ rule rationale endsWithSubCollection: '.' ] ])
		description: aRuleClass name , ' has no rationale'.
	runner := ReSmalllintChecker new.
	rules do: [ :each |
		runner
			rule: { each };
			environment: environment;
			run ].
	rules do: [ :each | | result |
		result := runner criticsOf: each. 
		self 
			assert: (rule = each or: [ result isEmpty or: [ ignoredRuleClasses includes: each class ] ])
			description: ('{1} should not report errors' format: { each name })  ].
	aBlock value: (runner criticsOf: rule).
	^ rule