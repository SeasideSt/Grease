running
tearDown

	super tearDown.
	factory cleanUp.
	SystemVersion current major >= 12 ifFalse:[
		(Smalltalk organization listAtCategoryNamed: self category) do:[ :e | SmalltalkImage current removeClassNamed: e ].
		Smalltalk organization removeCategory: self category ]