Extension { #name : 'SequenceableCollection' }

{ #category : '*grease-squeak6-core' }
SequenceableCollection >> beginsWithSubCollection: aSequenceableCollection [
	self
		greaseDeprecatedApi: 'SequenceableCollection>>#beginsWithSubCollection:'
		details: 'Use SequenceableCollection>>#greaseBeginsWith:'.
	"Some platforms implement #beginsWith: to answer true for an empty argument."
	aSequenceableCollection isEmpty ifTrue: [ ^ false ].
	^ self beginsWith: aSequenceableCollection
]

{ #category : '*grease-squeak6-core' }
SequenceableCollection >> endsWithSubCollection: aSequenceableCollection [
	self
		greaseDeprecatedApi: 'SequenceableCollection>>#endsWithSubCollection:'
		details: 'Use SequenceableCollection>>#greaseEndsWith:'.
	"Some platforms implement #endsWith: to answer true for an empty argument."
	aSequenceableCollection isEmpty ifTrue: [ ^ false ].
	^ self endsWith: aSequenceableCollection
]

{ #category : '*grease-squeak6-core' }
SequenceableCollection >> greaseBeginsWith: aSequenceableCollection [

	aSequenceableCollection isEmpty ifTrue: [ ^ true ].
	^ self beginsWith: aSequenceableCollection
]

{ #category : '*grease-squeak6-core' }
SequenceableCollection >> greaseEndsWith: aSequenceableCollection [

	aSequenceableCollection isEmpty ifTrue: [ ^ true ].
	^ self endsWith: aSequenceableCollection
]
