tests-block
testBasicNewInitializeMissing

	| class |
	class := self defineSubClassOf: #Object.
	self compile:  'initialize' in: class.
	self
		assertRule: GRBasicNewInitializeMissingRule
		expectedMatches: { class }