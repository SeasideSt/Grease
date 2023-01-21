dependencies
resolveWith: aDictionary
	dependencies := dependencies
		collect: [ :each |
			aDictionary at: each ifAbsent: [
				"if Foo-Pharo-Bar fails try Foo-Pharo20-Bar and Foo-Pharo30-Bar"
				(each indexOfSubCollection: '-Pharo-' startingAt: 1) ~= 0 ifTrue: [
					"try -Pharo40-"
					aDictionary at: (each copyReplaceAll: '-Pharo-' with: '-Pharo40-') ifAbsent: [
						"try -Pharo50-"
						aDictionary at: (each copyReplaceAll: '-Pharo-' with: '-Pharo50-') ifAbsent: [
							"try -Pharo60-"
							aDictionary at: (each copyReplaceAll: '-Pharo-' with: '-Pharo60-') ifAbsent: [
								"try -Pharo70-"
								aDictionary at: (each copyReplaceAll: '-Pharo-' with: '-Pharo70-') ifAbsent: [
									"try -Pharo90-"
									aDictionary at: (each copyReplaceAll: '-Pharo-' with: '-Pharo90-') ifAbsent: [
										"try -Pharo100-"
										aDictionary at: (each copyReplaceAll: '-Pharo-' with: '-Pharo100-') ifAbsent: [
											"try -Squeak-"
											aDictionary at: (each copyReplaceAll: '-Pharo-' with: '-Squeak-') ifAbsent: [
												"try -Squeak5-"
												aDictionary at: (each copyReplaceAll: '-Pharo-' with: '-Squeak5-') ifAbsent: [
													"try -Squeak6-"
													aDictionary at: (each copyReplaceAll: '-Pharo-' with: '-Squeak6-') ifAbsent: [
														"specific for Grease-Slime"
														aDictionary at: (each copyReplaceAll: 'Grease-Pharo-Slime' with: 'Grease-Slime') ifAbsent: [
															self error: self name printString , ' depends on unknown package ' , each printString ] ] ] ] ] ] ] ] ] ] ] ] ]