Extension { #name : 'GRPackage' }

{ #category : '*grease-squeak6-core' }
GRPackage class >> greaseSqueak6Core [
	^ self new
		name: 'Grease-Squeak6-Core';
		addDependency: 'Grease-Core';
		url: #greaseUrl;
		yourself
]
