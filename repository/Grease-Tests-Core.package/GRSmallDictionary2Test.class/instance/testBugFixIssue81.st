tests
testBugFixIssue81

	| dictionary |

	dictionary := GRSmallDictionary2 new
		at: 'x' put: 1;
		at: 'y' put: 2;
		at: 'z' put: 3;
		yourself.

	self
		assert: (dictionary removeKey: 'z') = 3;
		assert: dictionary size = 2.

	dictionary := GRSmallDictionary2 new
		at: 'x' put: 1;
		at: 'y' put: 2;
		at: 'z' put: 3;
		yourself.

	self
		assert: (dictionary removeKey: 'y') = 2;
		assert: dictionary size = 2