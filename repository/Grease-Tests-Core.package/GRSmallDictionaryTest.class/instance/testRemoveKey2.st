tests-testing
testRemoveKey2
	"https://github.com/SeasideSt/Grease/issues/81"
	collection
		at: 'x' put: 1;
		at: 'y' put: 2;
		at: 'z' put: 3;
		yourself.

	self
		assert: (collection removeKey: 'z') = 3;
		assert: collection size = 2.

	collection := self newCollection
		at: 'x' put: 1;
		at: 'y' put: 2;
		at: 'z' put: 3;
		yourself.

	self
		assert: (collection removeKey: 'y') = 2;
		assert: collection size = 2