running
rules

	^ (OrderedCollection new
		addAll: GRReSlimeBlockLintRule allSubclasses;
		addAll: GRReSlimeParseTreeLintRule allSubclasses;
		addAll: GRReSlimeTransformationRule allSubclasses;
		yourself) reject: #isAbstract