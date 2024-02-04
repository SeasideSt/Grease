tests-block
testReferencesNotPortableClass

	| class |
	class := self defineSubClassOf: #GRObject.
	class package: 'SomeCategory' tag: ''.
	self compile: 'invalid ^ Semaphore new' in: class.
	self compile: 'valid ^ GRObject new' in: class.
	self 
		assertRule: GRReferencesNotPortableClassRule
		matches: { class>>#invalid }