tests-block
testReferencesNotPortableClass

	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'invalid ^ Semaphore new' in: class.
	self compile: 'valid ^ GRObject new' in: class.
	self 
		assertRule: GRReferencesNotPortableClassRule
		matches: { class>>#invalid }