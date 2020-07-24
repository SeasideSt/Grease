file library
contentsOfFile: aString binary: aBoolean
	^ self readFileStreamOn: aString do: [ :stream | stream contents ] binary: aBoolean