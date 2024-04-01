tests-block
testInvalidObjectInitialization

	| class |
	class := self defineSubClassOf: #GRObject.
	self compile:  'initializeFoo: aNumber' in: class.
	self 
		assertRule: GRInvalidObjectInitializationRule
		matches: { class>>#initializeFoo: }