*Grease-Pharo100-Core
greaseEndsWith: aSequenceableCollection

	aSequenceableCollection isEmpty ifTrue: [ ^ true ].
	^ self endsWith: aSequenceableCollection