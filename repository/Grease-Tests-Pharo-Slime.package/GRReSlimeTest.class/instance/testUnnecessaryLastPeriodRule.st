tests-block
testUnnecessaryLastPeriodRule
	<expectedFailure>
	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'invalid 1. 2.' in: class.
	self compile: 'valid 1. 2' in: class.
	self 
		runRule: GRUnnecessaryLastPeriodRule
		selectors: #(invalid)