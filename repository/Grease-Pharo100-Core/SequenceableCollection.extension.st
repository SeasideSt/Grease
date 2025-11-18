Extension { #name : 'SequenceableCollection' }

{ #category : '*Grease-Pharo100-Core' }
SequenceableCollection >> beginsWithSubCollection: aSequenceableCollection [
	"Some platforms implement #beginsWith: to answer true for an empty argument."
	self
		greaseDeprecatedApi: 'SequenceableCollection>>#beginsWithSubCollection:'
		details: 'Use SequenceableCollection>>#greaseBegins:'.
	aSequenceableCollection isEmpty ifTrue: [ ^ false ].
	^ self beginsWith: aSequenceableCollection
]

{ #category : '*Grease-Pharo100-Core' }
SequenceableCollection >> endsWithSubCollection: aSequenceableCollection [
	"Some platforms implement #endsWith: to answer true for an empty argument."
	self
		greaseDeprecatedApi: 'SequenceableCollection>>#endsWithSubCollection:'
		details: 'Use SequenceableCollection>>#greaseEndsWith:'.
	aSequenceableCollection isEmpty ifTrue: [ ^ false ].
	^ self endsWith: aSequenceableCollection
]

{ #category : '*Grease-Pharo100-Core' }
SequenceableCollection >> greaseBeginsWith: aSequenceableCollection [

	aSequenceableCollection isEmpty ifTrue: [ ^ true ].
	^ self beginsWith: aSequenceableCollection
]

{ #category : '*Grease-Pharo100-Core' }
SequenceableCollection >> greaseEndsWith: aSequenceableCollection [

	aSequenceableCollection isEmpty ifTrue: [ ^ true ].
	^ self endsWith: aSequenceableCollection
]
