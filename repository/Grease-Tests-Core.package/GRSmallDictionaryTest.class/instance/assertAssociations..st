asserting
assertAssociations: anOrderedCollection
	| collAssociations iterated |
	collAssociations := collection associations.
	iterated := Array streamContents: [ :stream |
		collection associationsDo: [ :each | stream nextPut: each ] ].
	self assert: collAssociations size = anOrderedCollection size.
	self assert: iterated size = anOrderedCollection size.
	1 to: anOrderedCollection size do: [ :index |
		self assert: (collAssociations at: index) = (anOrderedCollection at: index).
		self assert: (iterated at: index) = (anOrderedCollection at: index) ]