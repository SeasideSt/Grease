transactions
doTransaction: aBlock
	"Evaluate aBlock in a transaction. 
	 Return true if the transaction succeeds and false if the transaction fails.
	 Nested calls are allowed and will always return true.
	 See System class>>transactionConflicts for dealing with failed transactions."

	System inTransaction
		ifTrue: [ "We alread in a transaction, so just evaluate the block"
			aBlock value.
			^true].
	self transactionMutex critical: [
		"Get the transactionMutex, and perform the transaction."
		[ 
			self doBeginTransaction.
			aBlock value.
		] ensure: [ 
			^self doCommitTransaction]].