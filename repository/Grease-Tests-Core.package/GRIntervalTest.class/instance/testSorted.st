tests
testSorted
	"Unlike super implementation do not assume Interval >> #sorted returns a new object"
	| sorted collection |
	collection := self arbitraryCollection.
	sorted := collection sorted.
	self assert: sorted validSequencedResponseFrom: collection.
	self assert: sorted sortedWith: [ :a :b | a <= b ].
	
	sorted := collection sorted: [ :a :b | a > b ].
	self assert: sorted validSequencedNewResponseFrom: collection.
	self assert: sorted sortedWith: [ :a :b | a > b ]