*grease-tests-slime
greaseTestsSlime
	^ self new
		name: 'Grease-Tests-Slime';
		description: 'Unit tests for the package Grease-Slime.';
		addDependency: 'Grease-Pharo-Slime';
		url: #seasideUrl;
		yourself