Extension { #name : 'SequenceableCollection' }

{ #category : '*Grease-Pharo90-Core' }
SequenceableCollection >> beginsWithSubCollection: aSequenceableCollection [

	self
		greaseDeprecatedApi: 'SequenceableCollection>>#beginsWithSubCollection:'
		details: 'Use SequenceableCollection>>#greaseBeginsWith:'.
	"Some platforms implement #beginsWith: to answer true for an empty argument."
	^ self beginsWith: aSequenceableCollection
]

{ #category : '*Grease-Pharo90-Core' }
SequenceableCollection >> endsWithSubCollection: aSequenceableCollection [

	self
		greaseDeprecatedApi: 'SequenceableCollection>>#endsWithSubCollection:'
		details: 'Use SequenceableCollection>>#greaseEndsWith:'.
	"Some platforms implement #endsWith: to answer true for an empty argument."
	^ self endsWith: aSequenceableCollection
]

{ #category : '*Grease-Pharo90-Core' }
SequenceableCollection >> greaseBeginsWith: aSequenceableCollection [

	aSequenceableCollection isEmpty ifTrue: [ ^ true ].
	^ self beginsWith: aSequenceableCollection
]

{ #category : '*Grease-Pharo90-Core' }
SequenceableCollection >> greaseEndsWith: aSequenceableCollection [

	aSequenceableCollection isEmpty ifTrue: [ ^ true ].
	^ self endsWith: aSequenceableCollection
]
