running
checkMethod: aMethod
	(self shouldExclude: aMethod) ifFalse: [
		aMethod pragmas do: [ :each |
			result 
				addClass: aMethod methodClass
				selector: aMethod selector.
			result addSearchString: each keyword ] ]