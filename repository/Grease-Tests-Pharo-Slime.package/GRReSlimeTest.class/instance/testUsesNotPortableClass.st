tests-block
testUsesNotPortableClass
	<expectedFailure>
	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'invalid ^ Semaphore new' in: class.
	self compile: 'valid ^ GRObject new' in: class.
	self 
		runRule: GRUsesNotPortableClassRule
		selectors: #(invalid)