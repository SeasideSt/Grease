tests
defineClass: aClassSymbol superclassName: aSuperSymbol category: aString forRBModel: aModel
	^ aModel defineClass: [ :builder |
		builder
			name: aClassSymbol;
			superclassName: aSuperSymbol;
			category: self category ]