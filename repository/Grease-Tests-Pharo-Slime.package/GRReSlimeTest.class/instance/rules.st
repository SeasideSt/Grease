accessing
rules
	^ OrderedCollection new
		addAll: GRReSlimeBlockLintRule allSubclasses;
		addAll: GRReSlimeParseTreeLintRule allSubclasses;
"		addAll: GRSlimeTransformationRule allSubclasses;"
		add: ReMultiplePeriodsTerminatingStatementRule;
		yourself