accessing-code
defineClass: aClassSymbol superclass: aSuperSymbol

	| class |
	class := factory silentlyMake: [ :aBuilder |
		         aBuilder
			         superclass: (Smalltalk at: aSuperSymbol);
			         package: self category ].
	environment
		addClass: class;
		addClass: class theMetaClass.
	^ class