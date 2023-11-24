running
tearDown

	super tearDown.
	factory cleanUp.
	"package := (Smalltalk organization packageNamed: self category).
	package classes do:[ :e | 
		SmalltalkImage current removeClassNamed: e name ].
	Smalltalk organization
		removePackage: package"