initialization
initialize

	super initialize.
	self matchesAny: #( 
		'`@receiver canPerform: `@selector'
		'`@receiver canUnderstand: `@selector' )