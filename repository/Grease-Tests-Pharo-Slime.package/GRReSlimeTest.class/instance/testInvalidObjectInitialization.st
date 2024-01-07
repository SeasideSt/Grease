tests-block
testInvalidObjectInitialization
	<expectedFailure>
	| class |
	class := self defineSubClassOf: #GRObject.
	self compile:  'initializeFoo: aNumber' in: class.
	self 
		runRule: GRInvalidObjectInitializationRule
		selectors: #(initializeFoo:)