asserting
assert: responseCollection validSequencedResponseFrom: receiverCollection
	"Assert that the returned object is of a valid response class for the tested collection."
	
	self assert: (self isValidNewSequencedResponseClass: responseCollection class)