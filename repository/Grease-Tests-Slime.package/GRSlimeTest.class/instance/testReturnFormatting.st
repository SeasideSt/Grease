tests-parsetree
testReturnFormatting
	| class |
	class := self defineSubClassOf: #GRObject.
	self
		compile: 'invalid1
			^1'
		in: class.
	self
		compile: 'invalid2
			^  2'
		in: class.
	self 
		runRule: GRReturnFormattingRule
		selectors: #(invalid1 invalid2)