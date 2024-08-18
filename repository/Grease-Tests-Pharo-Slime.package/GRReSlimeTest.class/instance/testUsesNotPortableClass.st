tests-block
testUsesNotPortableClass

	| class |
	class := self defineSubClassOf: #GRObject inPackage: 'SomeCategory'.
	self compile: 'invalid ^ Semaphore new' in: class.
	self compile: 'valid ^ GRObject new' in: class.
	self 
		assertRule: GRReferencesNotPortableClassRule
		matches: { class>>#invalid }