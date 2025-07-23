tests-mop
testCompileUnicodeString
	| selector expected source |
	selector := #stringMethod.
	expected := String
		with: (Character value: 16r1F1F3)
		with: (Character value: 16r1F1F1).
	source := GRPlatform current asMethodReturningString: expected named: selector.
	[ 
		| actual |
		GRPlatform current compile: source into: self class classified: 'private'.
		actual := self perform: selector.
		self assert: expected = actual
	] ensure: [ 
		GRPlatform current removeSelector: #stringMethod from: self class ]