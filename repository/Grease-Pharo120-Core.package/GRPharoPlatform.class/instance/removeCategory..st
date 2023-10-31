tests
removeCategory: aString
	(Smalltalk organization packageMatchingExtensionName: aString)
		ifNotNil: [ :package |
			package removeTag: (package toTagName: aString) ]