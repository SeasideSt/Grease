tests-block
testSubclassesNotPortableClass

	| class |
	class := self defineSubClassOf: #Mutex.
	class package: 'SomeCategory' tag: ''.
	self 
		assertRule: GRSubclassesNotPortableClassRule
		matches: { class }