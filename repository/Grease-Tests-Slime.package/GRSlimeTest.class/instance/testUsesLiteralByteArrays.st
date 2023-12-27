tests-parsetree
testUsesLiteralByteArrays
	| class |
	(self canParse: 'foo #[ 1 2 3 ]')
		ifFalse: [ ^ self ].
	class := self defineSubClassOf: #GRObject.
	self
		compile: 'invalid
			^ #[ 1 2 3 ]'
		in: class.
	self
		compile: 'valid
			^ ByteArray with: 1 with: 2 with: 3'
		in: class.
	self 
		runRule: GRUsesLiteralByteArraysRule
		selectors: #(invalid)