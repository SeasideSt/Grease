running
rules

	^ (OrderedCollection new
		addAll: GRSlimeBlockLintRule allSubclasses;
		addAll: GRSlimeParseTreeLintRule allSubclasses;
		addAll: GRSlimeTransformationRule allSubclasses;
		yourself) reject: #isAbstract