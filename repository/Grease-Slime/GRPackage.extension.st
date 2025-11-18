Extension { #name : 'GRPackage' }

{ #category : '*grease-slime' }
GRPackage class >> greaseSlime [
	^ self new
		name: 'Grease-Slime';
		description: 'Code critis for Grease. Detects common types of bugs and non-portable code.';
		addDependency: 'Grease-Core';
		url: #seasideUrl;
		yourself
]
