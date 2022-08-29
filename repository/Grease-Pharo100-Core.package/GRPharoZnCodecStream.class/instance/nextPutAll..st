streaming
nextPutAll: aString
	| string |
	string := aString asString.
	encoder next: string size putAll: string startingAt: 1 toStream: stream 