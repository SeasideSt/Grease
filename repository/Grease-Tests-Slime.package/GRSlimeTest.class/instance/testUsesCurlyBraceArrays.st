tests-parsetree
testUsesCurlyBraceArrays
	| class |
	(self canParse: 'foo { self foo. self bar }')
		ifFalse: [ ^ self ].
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
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