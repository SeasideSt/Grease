Extension { #name : 'Integer' }

{ #category : '*Grease-Core' }
Integer >> greaseAsByteArray [
	^ GRPlatform current integerAsByteArray: self
]

{ #category : '*Grease-Core' }
Integer >> greaseByteAt: index [
	^ self subclassResponsibility
]

{ #category : '*Grease-Core' }
Integer >> greaseBytesCount [
	^ self subclassResponsibility
]

{ #category : '*grease-core' }
Integer >> greaseInteger [
	^ self
]

{ #category : '*grease-core' }
Integer >> pluralize: aSingularString [
	^ self
		pluralize: aSingularString
		with: (GRInflector pluralize: aSingularString)
]

{ #category : '*grease-core' }
Integer >> pluralize: aSingularString with: aPluralString [
	^ self printString , ' ' , (self abs = 1 ifTrue: [ aSingularString ] ifFalse: [ aPluralString ])
]
