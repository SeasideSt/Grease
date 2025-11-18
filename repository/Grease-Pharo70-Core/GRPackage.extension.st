Extension { #name : 'GRPackage' }

{ #category : '*Grease-Pharo70-Core' }
GRPackage class >> greasePharo70Core [
	^ self new
		name: 'Grease-Pharo70-Core';
		addDependency: 'Grease-Core';
		url: #greaseUrl;
		yourself
]
