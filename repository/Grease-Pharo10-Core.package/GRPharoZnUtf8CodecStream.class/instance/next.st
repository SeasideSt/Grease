accessing
next
	| character |
	stream atEnd ifTrue: [ ^ nil ].
	character := encoder nextFromStream: stream.
	^ character ifNotNil: [ character asCharacter ]