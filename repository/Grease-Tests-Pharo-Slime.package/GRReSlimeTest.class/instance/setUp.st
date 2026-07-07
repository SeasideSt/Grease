running
setUp

	super setUp.
	factory := SystemVersion current major >= 12
		ifTrue: [ ClassFactoryForTestCase environment: (ClassFactoryForTestCase environment) ]
		ifFalse: [ ClassFactoryForTestCase new ].
	environment := RBClassEnvironment new