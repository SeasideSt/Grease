tests
testError
	"Make sure #error: signals a subclass of WAPlatformError."
	self 
		should: [ GRObject new error: 'oh dear' ]
		raise: GRError.
	self 
		should: [ GRObject error: 'oh dear' ]
		raise: GRError