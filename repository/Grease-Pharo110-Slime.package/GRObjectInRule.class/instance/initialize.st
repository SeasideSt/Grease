initialization
initialize

	super initialize.
	self
		replace: '``@object in: [ :`var | | `@temps | `@.statements ]'
		with: '[ :`var | | `@temps | `@.statements ] value: ``@object'