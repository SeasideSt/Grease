running
tearDown

	| package |
	super tearDown.
	factory cleanUp.
	SystemVersion current major >= 12 ifFalse:[
		package := (Smalltalk organization packageNamed: self category).
		package classes do:[ :e | 
			SmalltalkImage current removeClassNamed: e name ].
		Smalltalk organization
			removePackage: package ]