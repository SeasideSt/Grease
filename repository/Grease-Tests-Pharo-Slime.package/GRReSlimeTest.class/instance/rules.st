running
rules

	^ (OrderedCollection new
		addAll: GRReSlimeBlockLintRule allSubclasses;
		addAll: GRReSlimeParseTreeLintRule allSubclasses;
		addAll: GRReSlimeTransformationRule allSubclasses;
		add: ReMultiplePeriodsTerminatingStatementRule;
		add: ReMethodSignaturePeriodRule;
		yourself) reject: #isAbstract