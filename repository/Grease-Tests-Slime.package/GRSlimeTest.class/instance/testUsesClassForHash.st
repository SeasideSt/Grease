tests-parsetree
testUsesClassForHash
	| class |
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
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