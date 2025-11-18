Extension { #name : 'GRPackage' }

{ #category : '*Grease-Pharo100-Core' }
GRPackage class >> greasePharo100Core [
	^ self new
		name: 'Grease-Pharo100-Core';
		addDependency: 'Grease-Core';
		url: #greaseUrl;
		yourself
]
