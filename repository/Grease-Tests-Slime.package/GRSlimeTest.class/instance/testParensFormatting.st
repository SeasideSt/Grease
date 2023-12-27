tests-parsetree
testParensFormatting
	| class |
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
	self
		compile: 'invalid1
			( 1 + 2)'
		in: class.
	self
		compile: 'invalid2
			(1 + 2 )'
		in: class.
	self 
		runRule: GRParensFormattingRule
		selectors: #(invalid1 invalid2)