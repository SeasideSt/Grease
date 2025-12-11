tests-mop
testSourceCodeStringOf

	| sourceCodeString |
	sourceCodeString := GRPlatform current sourceCodeStringOf: GRPlatform >> #sourceCodeStringOf:.
	self
		assert: sourceCodeString
		equals: (GRPlatform current convertToSmalltalkNewlines: 
'sourceCodeStringOf: aCompiledMethod
	"Return a String with the source code for a compiled method."

	self subclassResponsibility')