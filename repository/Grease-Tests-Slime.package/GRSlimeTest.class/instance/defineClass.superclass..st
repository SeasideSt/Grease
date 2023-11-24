accessing-code
defineClass: aClassSymbol superclass: aSuperSymbol
	| class |
	SystemVersion current major >= 12
		ifTrue:[
			class := factory make: [ :aBuilder | 
				aBuilder
					name: aClassSymbol;
					superclass: (Smalltalk at: aSuperSymbol);
					package: self category ] ]
		ifFalse:[
			model defineClass: aSuperSymbol , ' subclass: #' , aClassSymbol , '
				instanceVariableNames: '''' 
				classVariableNames: ''''
				poolDictionaries: ''''
				category: ''' , self category , ''''.
		class := model classNamed: aClassSymbol ].
	environment 
		addClass: class;
		addClass: class theMetaClass.
	^ class