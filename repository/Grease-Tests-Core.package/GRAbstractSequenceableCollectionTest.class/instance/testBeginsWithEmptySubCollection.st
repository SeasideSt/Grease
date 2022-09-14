tests
testBeginsWithEmptySubCollection
	| collection | 
	collection := self arbitraryCollection.
	self deny: (self emptyCollection beginsWithSubCollection: collection)