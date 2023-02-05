*Grease-Pharo100-Core
endsWithSubCollection: aSequenceableCollection
	"Some platforms implement #endsWith: to answer true for an empty argument."
	self
		greaseDeprecatedApi: 'SequenceableCollection>>#endsWithSubCollection:'
		details: 'Use SequenceableCollection>>#greaseEndsWith:'.
	aSequenceableCollection isEmpty ifTrue: [ ^ false ].
	^ self endsWith: aSequenceableCollection