tests-block
testEmptyStatements
	"We added this test to make sure that this Pharo-supplied rule works because we previously had this one in Grease and it is important."

	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'emptyStatement1.', (String with: Character cr), ' self and' in: class.
	self compile: 'emptyStatement2', (String with: Character cr), ' self and..' in: class.
	self compile: 'emptyStatement3', (String with: Character cr), ' self and."foo".' in: class.
	self compile: 'emptyStatement4', (String with: Character cr), ' self and."foo".self and' in: class.
	self 
		assertRule: ReMultiplePeriodsTerminatingStatementRule
		matches: { class>>#emptyStatement2 . class>>#emptyStatement3 . class>>#emptyStatement4 }
		ignoring: { ReMethodSignaturePeriodRule }.
	self 
		assertRule: ReMethodSignaturePeriodRule
		matches: { class>>#emptyStatement1 }
		ignoring: { ReMultiplePeriodsTerminatingStatementRule }.