initialization
initialize

	super initialize.
	self
		matchesAny: #(
			'``@receiver greaseDeprecatedApi: ``@arg1'
			'``@receiver greaseDeprecatedApi: ``@arg1 details: ``@arg2' )