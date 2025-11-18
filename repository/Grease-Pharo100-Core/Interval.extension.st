Extension { #name : 'Interval' }

{ #category : '*Grease-Pharo100-Core' }
Interval >> any [
	"#first (used by SequenceableCollection>>anyOne) is an accessor of
	Interval and does not error on an empty Interval."

	^ self at: 1
]
