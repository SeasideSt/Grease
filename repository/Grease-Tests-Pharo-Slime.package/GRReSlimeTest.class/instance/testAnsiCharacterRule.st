tests-transform
testAnsiCharacterRule

	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'character Character value: 123' in: class.
	self compile: 'characterRange $a to: $c' in: class.
	self compile: 'integerRange 1 to: 10' in: class.
	self 
		runTransformation: GRAnsiCharactersRule
		changes: #('character Character codePoint: 123' 'characterRange ''abc''')