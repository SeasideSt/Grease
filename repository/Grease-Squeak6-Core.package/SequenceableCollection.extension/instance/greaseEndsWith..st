*grease-squeak6-core
greaseEndsWith: aSequenceableCollection

	aSequenceableCollection isEmpty ifTrue: [ ^ true ].
	^ self endsWith: aSequenceableCollection