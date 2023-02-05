*grease-squeak5-core
greaseEndsWith: aSequenceableCollection

	aSequenceableCollection isEmpty ifTrue: [ ^ true ].
	^ self endsWith: aSequenceableCollection