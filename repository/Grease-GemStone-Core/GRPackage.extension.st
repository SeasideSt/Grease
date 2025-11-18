Extension { #name : 'GRPackage' }

{ #category : '*grease-gemstone-core' }
GRPackage >> gemstoneUrl [
	^ 'http://seaside.gemstone.com/ss/Seaside30'
]

{ #category : '*grease-gemstone-core' }
GRPackage class >> greaseGemStoneCore [

	^ self new
		name: 'Grease-GemStone-Core';
		addDependency: 'Grease-Core';
		url: #gemstoneUrl;
		yourself
]
