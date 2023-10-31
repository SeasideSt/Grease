*Grease-Pharo120-Core
greaseEndsWith: aSequenceableCollection

	aSequenceableCollection isEmpty ifTrue: [ ^ true ].
	^ self endsWith: aSequenceableCollection