*Grease-Pharo90-Slime
greaseSlime
	^ self new
		name: 'Grease-Pharo90-Slime';
		description: 'Code critis for Grease. Detects common types of bugs and non-portable code.';
		addDependency: 'Grease-Core';
		url: #seasideUrl;
		yourself