initialization
initialize

	super initialize.
	self
		replace: '``@block on: `class do: [ | `@temps | ``@.body ]'
			with: '``@block on: `class do: [ :err | | `@temps | ``@.body ]'