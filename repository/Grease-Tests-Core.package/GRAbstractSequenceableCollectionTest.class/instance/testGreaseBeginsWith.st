tests
testGreaseBeginsWith
	| collection |
	collection := self arbitraryCollection.
	self assert: (collection greaseBeginsWith: (collection copyWithout: collection last)).
	self assert: (collection greaseBeginsWith: collection).
	self deny: (collection greaseBeginsWith: (collection copyWith: collection first)).
	self assert: (collection greaseBeginsWith: self emptyCollection).
	self deny: (self emptyCollection greaseBeginsWith: collection)