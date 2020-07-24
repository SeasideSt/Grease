*grease-tests-gemstone32-core
greaseTestsGemStoneCore

	^ self new
		name: 'Grease-Tests-GemStone32-Core';
		addDependency: 'Grease-GemStone-Core';
		addDependency: 'Grease-Tests-Core';
		url: #gemstoneUrl;
		yourself