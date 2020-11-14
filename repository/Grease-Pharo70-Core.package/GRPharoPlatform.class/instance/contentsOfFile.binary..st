file library
contentsOfFile: aString binary: aBoolean
	^ aBoolean
		ifTrue:[ self fileStreamOn: aString do: [ :stream | stream contents ifNil:[ ByteArray new ] ] binary: aBoolean ]
		ifFalse:[ self fileStreamOn: aString do: [ :stream | stream contents ] binary: aBoolean ]