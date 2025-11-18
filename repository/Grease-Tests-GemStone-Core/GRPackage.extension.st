Extension { #name : 'GRPackage' }

{ #category : '*grease-tests-gemstone-core' }
GRPackage class >> greaseTestsGemStoneCore [

	^ self new
		name: 'Grease-Tests-GemStone-Core';
		addDependency: 'Grease-GemStone-Core';
		addDependency: 'Grease-Tests-Core';
		url: #gemstoneUrl;
		yourself
]
