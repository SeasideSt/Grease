tests-utilites
separate: aString left: aCharacter
	| converter |
	converter := GRNumberPrinter new.
	^ String streamContents: [ :stream |
		converter 
			separate: aString
			left: aCharacter
			on: stream ]