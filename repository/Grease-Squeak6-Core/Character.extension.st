Extension { #name : 'Character' }

{ #category : '*grease-squeak6-core' }
Character >> greaseInteger [
	"Answer an unicode code point of the receiver."
	^ self asUnicode
]
