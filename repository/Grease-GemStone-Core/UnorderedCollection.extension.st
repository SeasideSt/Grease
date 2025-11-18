Extension { #name : 'UnorderedCollection' }

{ #category : '*grease-gemstone-core' }
UnorderedCollection >> copyFrom: anObject [

	(anObject isKindOf: UnorderedCollection) ifFalse: [
		^super copyFrom: anObject.
	].
	self removeAll: self copy.
	self addAll: anObject.
]
