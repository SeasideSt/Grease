Extension { #name : 'SequenceableCollection' }

{ #category : '*Grease-Pharo70-Core' }
SequenceableCollection >> beginsWithSubCollection: aSequenceableCollection [
	"Some platforms implement #beginsWith: to answer true for an empty argument."
	^ self beginsWith: aSequenceableCollection
]

{ #category : '*Grease-Pharo70-Core' }
SequenceableCollection >> endsWithSubCollection: aSequenceableCollection [
	"Some platforms implement #endsWith: to answer true for an empty argument."
	^ self endsWith: aSequenceableCollection
]

{ #category : '*Grease-Pharo70-Core' }
SequenceableCollection >> greaseBeginsWith: aSequenceableCollection [

	aSequenceableCollection isEmpty ifTrue: [ ^ true ].
	^ self beginsWith: aSequenceableCollection
]

{ #category : '*Grease-Pharo70-Core' }
SequenceableCollection >> greaseEndsWith: aSequenceableCollection [

	aSequenceableCollection isEmpty ifTrue: [ ^ true ].
	^ self endsWith: aSequenceableCollection
]

{ #category : '*Grease-Pharo70-Core' }
SequenceableCollection >> sorted [
	^ self sorted: [ :a :b | a <= b ]
]
