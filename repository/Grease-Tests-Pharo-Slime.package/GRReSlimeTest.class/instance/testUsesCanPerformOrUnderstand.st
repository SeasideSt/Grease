tests-parsetree
testUsesCanPerformOrUnderstand

	| class |
	class := self defineSubClassOf: #GRObject.
	self
		compile: 'invalid1
			Object class canUnderstand: #new'
		in: class.
	self
		compile: 'invalid2
			Object class canPerform: #new'
		in: class.
	self
		compile: 'valid
			Object respondsTo: #new'
		in: class.
	self 
		assertRule: GRUsesCanPerformOrUnderstandRule
		matches: { class>>#invalid1 . class>>#invalid2 }