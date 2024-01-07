tests-block
testUsesNotPortableClass

	| class |
	class := self defineSubClassOf: #GRObject.
	class category: 'SomeCategory'.
	self compile: 'invalid ^ Semaphore new' in: class.
	self compile: 'valid ^ GRObject new' in: class.
	self 
		assertRule: GRReferencesNotPortableClassRule
		matches: { class>>#invalid }