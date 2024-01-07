tests-block
testUnnecessaryLastPeriodRule

	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'invalid 1. 2.' in: class.
	self compile: 'valid 1. 2' in: class.
	self 
		assertRule: ReUnnecessaryLastPeriodRule
		matches: { class>>#invalid }