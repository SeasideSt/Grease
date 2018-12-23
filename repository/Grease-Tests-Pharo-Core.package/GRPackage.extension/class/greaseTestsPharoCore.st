*Grease-Tests-Pharo-Core
greaseTestsPharoCore
	^ self new
		name: 'Grease-Tests-Pharo-Core';
		description: 'Unit tests for the package Grease-Pharo-Core.';
		addDependency: 'Grease-Pharo-Core';
		addDependency: 'Grease-Tests-Core';
		url: #greaseUrl;
		yourself