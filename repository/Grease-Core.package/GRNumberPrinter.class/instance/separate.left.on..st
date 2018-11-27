utilities
separate: aString left: aCharacter on: aStream
	"Separate from the left side every 3 characters with aCharacter."
		
	| size |
	size := aString size.
	1 to: size do: [ :index |
		(index ~= 1 and: [ index \\ 3 = 1 ])
			ifTrue: [ aStream nextPut: aCharacter ].
		aStream nextPut: (aString at: index) ]