Extension { #name : 'Array' }

{ #category : '*grease-gemstone-core' }
Array >> beMutable [
	"for VW compatibility, a hack that allows to cache a value in a literal array"

	^self copy.
]
