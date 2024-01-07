tests-parsetree
testUsesCurlyBraceArrays
	<expectedFailure>
	| class |
	(self canParse: 'foo { self foo. self bar }')
		ifFalse: [ ^ self ].
	class := self defineSubClassOf: #GRObject.
	self
		compile: 'invalid
			^ { self foo. self bar }'
		in: class.
	self
		compile: 'valid
			^ Array new'
		in: class.
	self 
		runRule: GRUsesCurlyBraceArraysRule
		selectors: #(invalid)