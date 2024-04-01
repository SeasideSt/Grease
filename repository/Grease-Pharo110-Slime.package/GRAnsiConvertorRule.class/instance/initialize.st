initialization
initialize

	super initialize.
	self
		replace: '``@object asString' with: '``@object greaseString';
		replace: '``@object asInteger' with: '``@object greaseInteger'