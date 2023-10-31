accessing-code
defineClass: aClassSymbol superclass: aSuperSymbol

	| class |
	GRPlatform current
		defineClass: aClassSymbol
		superclassName: aSuperSymbol
		category: self category
		forRBModel: model.
	class := model classNamed: aClassSymbol.
	environment
		addClass: class;
		addClass: (GRPlatform current classSideOf: class).
	^ class