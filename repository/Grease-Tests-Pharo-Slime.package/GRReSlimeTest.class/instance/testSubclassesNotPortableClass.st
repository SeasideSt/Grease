tests-block
testSubclassesNotPortableClass

	| class |
	class := self defineSubClassOf: #Mutex.
	self 
		assertRule: GRSubclassesNotPortableClassRule
		matches: { class }