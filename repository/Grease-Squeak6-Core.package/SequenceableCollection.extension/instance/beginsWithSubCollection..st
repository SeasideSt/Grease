*grease-squeak6-core
beginsWithSubCollection: aSequenceableCollection
	self
		greaseDeprecatedApi: 'SequenceableCollection>>#beginsWithSubCollection:'
		details: 'Use SequenceableCollection>>#greaseBeginsWith:'.
	"Some platforms implement #beginsWith: to answer true for an empty argument."
	aSequenceableCollection isEmpty ifTrue: [ ^ false ].
	^ self beginsWith: aSequenceableCollection