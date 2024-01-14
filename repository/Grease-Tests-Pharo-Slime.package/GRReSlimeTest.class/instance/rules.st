running
rules

	^ (OrderedCollection new
		addAll: GRSlimeBlockLintRule allSubclasses;
		addAll: GRSlimeParseTreeLintRule allSubclasses;
		addAll: GRSlimeTransformationRule allSubclasses;
		add: ReMultiplePeriodsTerminatingStatementRule;
		add: ReMethodSignaturePeriodRule;
		yourself) reject: #isAbstract