running
basicCheck: aClass

	^ aClass isMeta not
		and: [ (aClass includesSelector: #initialize)
		and: [ (#(GRObject GRNotification GRNotification GRError RBLintRule RBTransformationRule) noneSatisfy: [ :each |
				aClass includesBehavior: (Smalltalk globals at: each) ])
		and: [ aClass class methodDictionary noneSatisfy: [ :each |
				matcher
					executeTree: each parseTree
					initialAnswer: false ] ] ] ]