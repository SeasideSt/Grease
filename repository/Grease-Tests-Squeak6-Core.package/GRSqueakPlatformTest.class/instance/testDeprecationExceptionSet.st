tests
testDeprecationExceptionSet
	| value |
	value := [
		"intentially send Squeak instead of Grease deprecation message"
		self deprecated: 'test'.
		'failed' ]
			on: GRDeprecatedApiNotification, GRPlatform current deprecationExceptionSet
			do: [ :e | 'passed' ].
	self assert: value = 'passed'