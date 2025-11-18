Extension { #name : 'GRPackage' }

{ #category : '*Grease-Pharo90-Core' }
GRPackage class >> greasePharo70Core [
	^ self new
		name: 'Grease-Pharo90-Core';
		addDependency: 'Grease-Core';
		url: #greaseUrl;
		yourself
]
