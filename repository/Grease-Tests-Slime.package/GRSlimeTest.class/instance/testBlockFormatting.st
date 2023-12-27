tests-parsetree
testBlockFormatting
	| class |
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
	self 
		compile: 'invalid1
			[:a ]'
		in: class.
	self
		compile: 'invalid2
			[:a | ]'
		in: class.
	self
		compile: 'invalid3
			[ :b]'
		in: class.
	
	self
		compile: 'invalid4
			[ :a| ]'
		in: class.
	self
		compile: 'invalid5
			[ :a |a ]'
		in: class.
	self 
		runRule: GRBlockFormattingRule
		selectors: #(invalid1 invalid2 invalid3 invalid4 invalid5)