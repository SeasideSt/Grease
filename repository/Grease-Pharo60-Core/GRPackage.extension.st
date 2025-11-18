Extension { #name : 'GRPackage' }

{ #category : '*Grease-Pharo60-Core' }
GRPackage class >> greasePharo60Core [
	^ self new
		name: 'Grease-Pharo60-Core';
		addDependency: 'Grease-Core';
		url: #greaseUrl;
		yourself
]
