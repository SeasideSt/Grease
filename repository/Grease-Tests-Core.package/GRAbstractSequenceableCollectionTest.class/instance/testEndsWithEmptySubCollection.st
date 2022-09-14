tests
testEndsWithEmptySubCollection
	| collection | 
	collection := self arbitraryCollection.
	self deny: (self emptyCollection endsWithSubCollection: collection)