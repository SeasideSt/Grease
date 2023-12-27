tests-parsetree
testUsesClassForHash
	| class |
	class := self defineSubClassOf: #GRObject.
	self
		compile: 'foo
			^ super hash bitXor: self class hash'
		in: class.
	self
		compile: 'hash
			^ super hash bitXor: self class hash'
		in: class.
	self 
		runRule: GRUsesClassForHashRule
		selectors: #(hash)