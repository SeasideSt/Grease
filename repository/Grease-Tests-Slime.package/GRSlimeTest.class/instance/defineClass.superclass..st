accessing-code
defineClass: aClassSymbol superclass: aSuperSymbol
	| class |
	class := factory make: [ :aBuilder | 
		aBuilder
			name: aClassSymbol;
			superclass: aSuperSymbol;
			package: self category ]
		
	"aSuperSymbol , ' subclass: #' , aClassSymbol , '
		instanceVariableNames: '''' 
		classVariableNames: ''''
		poolDictionaries: ''''
		category: ''' , self category , ''''".
	"class := model classNamed: aClassSymbol."
	environment 
		addClass: class;
		addClass: class theMetaClass.
	^ class