tests-block
testEmptyStatements
	"We added this test to make sure that this Pharo-supplied rule works because we previously had this one in Grease and it is important."
	<expectedFailure>

	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'emptyStatement1. self and' in: class.
	self compile: 'emptyStatement2 self and..' in: class.
	self compile: 'emptyStatement3 self and."foo".' in: class.
	self compile: 'emptyStatement4 self and."foo".self and' in: class.
	self 
		assertRule: ReMultiplePeriodsTerminatingStatementRule
		matches: { class>>#emptyStatement1 . class>>#emptyStatement2 . class>>#emptyStatement3 . class>>#emptyStatement4 }
		ignoring: (Array with: GRUnnecessaryLastPeriodRule)