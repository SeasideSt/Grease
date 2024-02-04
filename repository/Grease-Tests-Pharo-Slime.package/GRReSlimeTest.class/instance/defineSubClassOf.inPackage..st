accessing-code
defineSubClassOf: aSuperSymbol inPackage: packageName

	| class |
	class := SystemVersion current major >= 12
		         ifTrue: [
			         factory make: [ :aBuilder |
				         aBuilder
					         superclass: (Smalltalk at: aSuperSymbol);
					         package: packageName ] ]
		         ifFalse: [
			         factory
				         newSubclassOf: (Smalltalk at: aSuperSymbol)
				         instanceVariableNames: ''
				         classVariableNames: 'classVarsString'
				         category: packageName ].
	environment
		addClass: class;
		addClass: class classSide.
	^ class