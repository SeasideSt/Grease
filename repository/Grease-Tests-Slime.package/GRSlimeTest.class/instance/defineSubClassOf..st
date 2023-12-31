accessing-code
defineSubClassOf: aSuperSymbol

	| class |
	class := SystemVersion current major >= 12
		         ifTrue: [
			         factory make: [ :aBuilder |
				         aBuilder
					         superclass: (Smalltalk at: aSuperSymbol);
					         package: self category ] ]
		         ifFalse: [
			         factory
				         newSubclassOf: (Smalltalk at: aSuperSymbol)
				         instanceVariableNames: ''
				         classVariableNames: 'classVarsString'
				         category: self category ].
	environment
		addClass: class;
		addClass: class theMetaClass.
	^ class