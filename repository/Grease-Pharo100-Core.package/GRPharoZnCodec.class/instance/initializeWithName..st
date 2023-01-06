initialization
initializeWithName: aString
	self initialize.
	name := aString.
	urlCodec := (#('iso-8859-15' 'cp-1252' 'utf8' 'utf-8' 'UTF-8') includes: aString)
		ifFalse: [ GRCodec forEncoding: 'utf8' ]
		ifTrue: [ self ]