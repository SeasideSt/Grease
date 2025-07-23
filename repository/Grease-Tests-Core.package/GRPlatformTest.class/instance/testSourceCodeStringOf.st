tests-mop
testSourceCodeStringOf

	| sourceCodeString |
	sourceCodeString := GRPlatform current sourceCodeStringOf:
		                    GRPlatform >> #sourceCodeStringOf:.
	self
		assert: sourceCodeString
		equals: 'sourceCodeStringOf: aCompiledMethod
	"Return a String with the source code for a compiled method."

	^ self convertToSmalltalkNewlines: aCompiledMethod sourceCode'