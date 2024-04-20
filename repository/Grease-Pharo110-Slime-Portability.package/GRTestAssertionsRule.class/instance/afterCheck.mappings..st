hooks
afterCheck: aNode mappings: mappingsDict

	aNode methodNode methodClass isMeta
		ifTrue: [ ^ false ].
	(aNode methodNode methodClass allSuperclasses includes: (Smalltalk at: #TestCase))
		ifTrue: [ ^ true ].
	^ false