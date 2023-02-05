*Grease-Pharo100-Core
greaseBeginsWith: aSequenceableCollection
	aSequenceableCollection isEmpty ifTrue: [ ^ true ].
	^ self beginsWith: aSequenceableCollection