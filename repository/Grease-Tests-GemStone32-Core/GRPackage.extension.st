Extension { #name : 'GRPackage' }

{ #category : '*grease-tests-gemstone32-core' }
GRPackage class >> greaseTestsGemStoneCore [

	^ self new
		name: 'Grease-Tests-GemStone32-Core';
		addDependency: 'Grease-GemStone-Core';
		addDependency: 'Grease-Tests-Core';
		url: #gemstoneUrl;
		yourself
]
