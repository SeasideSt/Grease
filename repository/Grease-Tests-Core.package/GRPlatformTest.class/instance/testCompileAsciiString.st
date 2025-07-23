tests-mop
testCompileAsciiString
	| selector expected source |
	
	GRPlatform current supportsUnicode ifFalse: [
		^ self ].
	
	selector := #stringMethod.
	expected := 'test ok'.
	source := GRPlatform current asMethodReturningString: expected named: selector.
	[ 
		| actual |
		GRPlatform current compile: source into: self class classified: 'private'.
		actual := self perform: selector.
		self assert: expected = actual
	] ensure: [ 
		GRPlatform current removeSelector: #stringMethod from: self class ]