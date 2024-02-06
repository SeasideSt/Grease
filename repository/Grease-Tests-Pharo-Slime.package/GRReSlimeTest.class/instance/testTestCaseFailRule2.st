tests-transform
testTestCaseFailRule2

	| class |			
	class := self defineSubClassOf: #Object.
	self compile: 'method self fail' in: class.
	self 
		runTransformation: GRTestAssertionsRule
		changes: #( )