accessing-code
rules

	^ (OrderedCollection new
		addAll: GRReSlimeBlockLintRule allSubclasses;
		addAll: GRReSlimeParseTreeLintRule allSubclasses;
"		addAll: GRSlimeTransformationRule allSubclasses;"
		add: ReMultiplePeriodsTerminatingStatementRule;
		add: ReUnnecessaryLastPeriodRule;
		yourself) reject: #isAbstract