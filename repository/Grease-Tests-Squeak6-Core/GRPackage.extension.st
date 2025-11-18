Extension { #name : 'GRPackage' }

{ #category : '*grease-tests-squeak6-core' }
GRPackage class >> greaseTestsSqueak6Core [
	^ self new
		name: 'Grease-Tests-Squeak6-Core';
		description: 'Unit tests for the package Grease-Squeak6-Core.';
		addDependency: 'Grease-Squeak6-Core';
		addDependency: 'Grease-Tests-Core';
		url: #seasideUrl;
		yourself
]
