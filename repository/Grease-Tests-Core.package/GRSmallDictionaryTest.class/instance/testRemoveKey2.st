tests-accessing
testRemoveKey2
	"https://github.com/SeasideSt/Grease/issues/81"
	collection
		at: 'x' put: 1;
		at: 'y' put: 2;
		at: 'z' put: 3.

	self
		assert: (collection removeKey: 'z') equals: (self allowsDuplicateKeys ifTrue: [ #(3) ] ifFalse: [ 3 ]);
		assert: collection size equals: 2.

	collection := self newCollection
		at: 'x' put: 1;
		at: 'y' put: 2;
		at: 'z' put: 3;
		yourself.	
			
	self
		assert: (collection removeKey: 'y') equals: (self allowsDuplicateKeys ifTrue: [ #(2) ] ifFalse: [ 2 ]);
		assert: collection size equals: 2