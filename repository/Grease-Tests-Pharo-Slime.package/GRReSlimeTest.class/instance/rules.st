running
rules

	^ (OrderedCollection new
		addAll: GRReSlimeBlockLintRule allSubclasses;
		addAll: GRReSlimeParseTreeLintRule allSubclasses;
"		addAll: GRSlimeTransformationRule allSubclasses;"
		yourself) reject: #isAbstract