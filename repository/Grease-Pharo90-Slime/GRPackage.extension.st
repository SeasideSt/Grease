Extension { #name : 'GRPackage' }

{ #category : '*Grease-Pharo90-Slime' }
GRPackage class >> greaseSlime [
	^ self new
		name: 'Grease-Pharo90-Slime';
		description: 'Code critis for Grease. Detects common types of bugs and non-portable code.';
		addDependency: 'Grease-Core';
		url: #seasideUrl;
		yourself
]
