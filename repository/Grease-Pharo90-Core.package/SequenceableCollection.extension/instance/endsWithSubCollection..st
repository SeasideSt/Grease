*Grease-Pharo90-Core
endsWithSubCollection: aSequenceableCollection

	self
		greaseDeprecatedApi: 'SequenceableCollection>>#endsWithSubCollection:'
		details: 'Use SequenceableCollection>>#greaseEndsWith:'.
	"Some platforms implement #endsWith: to answer true for an empty argument."
	^ self endsWith: aSequenceableCollection