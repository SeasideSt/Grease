tests-block
testUsesMethodAnnotations
	<expectedFailure>
	| class |
	(self canParse: 'foo <foo: 123>')
		ifFalse: [ ^ self ].
	class := self defineSubClassOf: #GRObject.
	self compile: 'invalid <foo: 123>' in: class.
	self compile: 'valid' in: class.
	self 
		runRule: GRUsesMethodAnnotationsRule
		selectors: #(invalid)