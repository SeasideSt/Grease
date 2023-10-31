running
checkClass: aClass
	aClass allSuperclassesDo: [ :each |
		(self classNames includes: each name) ifTrue: [
			result addClass: aClass.
			result addSearchString: each name ] ]