accessing
next
	| character |
	stream atEnd ifTrue: [ ^ nil ].
	character := encoder nextFromStream: stream.
	^ character isNil
		ifFalse: [ character asCharacter ]