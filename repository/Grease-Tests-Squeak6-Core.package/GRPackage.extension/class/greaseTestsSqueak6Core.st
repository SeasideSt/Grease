*grease-tests-squeak6-core
greaseTestsSqueak6Core
	^ self new
		name: 'Grease-Tests-Squeak6-Core';
		description: 'Unit tests for the package Grease-Squeak6-Core.';
		addDependency: 'Grease-Squeak6-Core';
		addDependency: 'Grease-Tests-Core';
		url: #seasideUrl;
		yourself