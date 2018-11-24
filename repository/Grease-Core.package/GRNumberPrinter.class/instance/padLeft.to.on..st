utilities
padLeft: aCharacter to: aPadCountInteger on: aStream
	"Pad to the left side of aString with aCharacter to at anInteger characters."

	1 to: aPadCountInteger do: [ :index |
		separator isNil ifFalse: [
			(index ~= 1 and: [ (digits - index) \\ 3 = 2 ])
				ifTrue: [ aStream nextPut: separator ] ].
		aStream nextPut: aCharacter ]