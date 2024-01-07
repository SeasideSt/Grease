tests-parsetree
testTempsFormatting
	<expectedFailure>
	| class |
	class := self defineSubClassOf: #GRObject.
	self
		compile: 'invalid1
			| a|'
		in: class.
	self
		compile: 'invalid2
			|a |'
		in: class.
	self
		compile: 'invalid3
			| a  b |'
		in: class.
	self 
		runRule: GRTempsFormattingRule
		selectors: #(invalid1 invalid2 invalid3)