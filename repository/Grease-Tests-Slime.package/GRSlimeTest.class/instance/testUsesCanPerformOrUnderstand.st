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
		runRule: GRUsesCanPerformOrUnderstandRule
		selectors: #(invalid1 invalid2)