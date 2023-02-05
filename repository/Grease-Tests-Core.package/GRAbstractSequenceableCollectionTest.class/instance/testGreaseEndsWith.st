tests
testGreaseEndsWith
	| collection |
	collection := self arbitraryCollection.
	self assert: (collection greaseEndsWith: (collection copyWithout: collection first)).
	self assert: (collection greaseEndsWith: collection).
	self deny: (collection greaseEndsWith: (collection copyWith: collection first)).
	self assert: (collection greaseEndsWith: self emptyCollection).
	self deny: (self emptyCollection greaseEndsWith: collection)