Extension { #name : 'Behavior' }

{ #category : '*grease-gemstone-core' }
Behavior >> fullName [
	"In VW, will include the namespace"
	^self name
]

{ #category : '*grease-gemstone-core' }
Behavior >> removeSelectorSilently: aString [

	self removeSelector: aString.
]
