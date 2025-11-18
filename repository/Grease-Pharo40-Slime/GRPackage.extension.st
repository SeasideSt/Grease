Extension { #name : 'GRPackage' }

{ #category : '*Grease-Pharo40-Slime' }
GRPackage class >> greaseSlime [
	^ self new
		name: 'Grease-Pharo40-Slime';
		description: 'Code critis for Grease. Detects common types of bugs and non-portable code.';
		addDependency: 'Grease-Core';
		url: #seasideUrl;
		yourself
]
