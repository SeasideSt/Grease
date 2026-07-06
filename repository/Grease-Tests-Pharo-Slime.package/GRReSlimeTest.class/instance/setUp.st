running
setUp

	super setUp.
	factory := ClassFactoryForTestCase environment: (ClassFactoryForTestCase environment).
	environment := RBClassEnvironment new