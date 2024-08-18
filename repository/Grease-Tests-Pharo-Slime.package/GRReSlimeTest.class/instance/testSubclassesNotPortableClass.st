tests-block
testSubclassesNotPortableClass

	| class |
	class := self defineSubClassOf: #Mutex inPackage: 'SomeCategory'.
	self 
		assertRule: GRSubclassesNotPortableClassRule
		matches: { class }