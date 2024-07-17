exceptions
deprecationExceptionSet
	"Answer the exception set that should considered besides WADeprecation."
	^ ExceptionSet new
		add: Deprecation;
		yourself