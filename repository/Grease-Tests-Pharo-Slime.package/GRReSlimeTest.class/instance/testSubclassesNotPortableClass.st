tests-block
testSubclassesNotPortableClass

	| class |
	class := self defineSubClassOf: #Mutex.
	class category: 'SomeCategory'.
	self 
		assertRule: GRSubclassesNotPortableClassRule
		matches: { class }