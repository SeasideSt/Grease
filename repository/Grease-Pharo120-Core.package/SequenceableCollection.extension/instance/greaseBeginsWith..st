*Grease-Pharo120-Core
greaseBeginsWith: aSequenceableCollection

	aSequenceableCollection isEmpty ifTrue: [ ^ true ].
	^ self beginsWith: aSequenceableCollection