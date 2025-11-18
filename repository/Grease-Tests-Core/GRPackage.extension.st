Extension { #name : 'GRPackage' }

{ #category : '*grease-tests-core' }
GRPackage class >> greaseTestsCore [
	^ self new
		name: 'Grease-Tests-Core';
		description: 'Unit tests for the package Grease-Core.';
		addDependency: 'Grease-Core';
		url: #greaseUrl;
		yourself
]
