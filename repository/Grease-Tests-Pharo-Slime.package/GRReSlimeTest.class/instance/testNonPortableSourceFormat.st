tests-block
testNonPortableSourceFormat
	<expectedFailure>
	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'invalid ^ ''Unicode snow man', (String with: (Character codePoint: 16r2603)) , '''' in: class.
	self compile: 'valid ^ ''everything is fine''' in: class.
	self 
		runRule: GRNonPortableSourceFormatRule
		selectors: #(invalid)