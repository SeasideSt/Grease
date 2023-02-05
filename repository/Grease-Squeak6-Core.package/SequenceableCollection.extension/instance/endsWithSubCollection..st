*grease-squeak6-core
endsWithSubCollection: aSequenceableCollection
	self
		greaseDeprecatedApi: 'SequenceableCollection>>#endsWithSubCollection:'
		details: 'Use SequenceableCollection>>#greaseEndsWith:'.
	"Some platforms implement #endsWith: to answer true for an empty argument."
	aSequenceableCollection isEmpty ifTrue: [ ^ false ].
	^ self endsWith: aSequenceableCollection