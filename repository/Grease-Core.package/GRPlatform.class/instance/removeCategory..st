tests
removeCategory: aString
	(Smalltalk organization listAtCategoryNamed: aString) do:[ :e | 
		SmalltalkImage current removeClassNamed: e ].
	Smalltalk organization
		removeCategory: aString