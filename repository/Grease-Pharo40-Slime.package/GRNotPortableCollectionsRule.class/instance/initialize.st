initialization
initialize
	super initialize.
	self rewriteRule
		replace: '`@collection beginsWith: `@subCollection'
			with: '`@collection greaseBeginsWith: `@subCollection';
		replace: '`@collection endsWith: `@subCollection'
			with: '`@collection greaseEndsWith: `@subCollection'