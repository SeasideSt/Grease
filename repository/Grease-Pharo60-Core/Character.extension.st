Extension { #name : 'Character' }

{ #category : '*Grease-Pharo60-Core' }
Character >> greaseInteger [
	"Answer an unicode code point of the receiver."
	^ self charCode
]
