testing
testUniqueIdentifierName
	"see https://github.com/SeasideSt/Grease/pull/202"
	| result |
	result := ReSmalllintTest run: #testUniqueIdentifierName.
	self assert: result hasPassed