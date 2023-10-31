*Grease-Pharo120-Core
beginsWithSubCollection: aSequenceableCollection
	"Some platforms implement #beginsWith: to answer true for an empty argument."
	self
		greaseDeprecatedApi: 'SequenceableCollection>>#beginsWithSubCollection:'
		details: 'Use SequenceableCollection>>#greaseBegins:'.
	aSequenceableCollection isEmpty ifTrue: [ ^ false ].
	^ self beginsWith: aSequenceableCollection