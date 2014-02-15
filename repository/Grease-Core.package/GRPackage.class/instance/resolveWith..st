dependencies
resolveWith: aDictionary
	dependencies := dependencies 
		collect: [ :each |
			aDictionary at: each ifAbsent: [
				"if Foo-Pharo-Bar fails try Foo-Pharo20-Bar and Foo-Pharo30-Bar"
				(each indexOfSubCollection: '-Pharo-' startingAt: 0) ~= 0 ifTrue: [ 
					"try -Pharo20-"
					aDictionary at: (each copyReplaceAll: '-Pharo-' with: '-Pharo20-') ifAbsent: [
						"try -Pharo30-"
						aDictionary at: (each copyReplaceAll: '-Pharo-' with: '-Pharo30-') ifAbsent: [
							self error: self name printString , ' depends on unknown package ' , each printString ] ] ] ] ]