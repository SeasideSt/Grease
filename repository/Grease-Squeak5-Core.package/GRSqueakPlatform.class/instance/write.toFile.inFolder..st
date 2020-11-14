file library
write: aStringOrByteArray toFile: aFileNameString inFolder: aFolderString 
	| folder fullFilePath |
	fullFilePath := FileDirectory default fullNameFor: aFolderString.
	folder := FileDirectory on: fullFilePath.
	(folder fileExists: aFileNameString)
		ifTrue: [folder deleteFileNamed: aFileNameString].
	^ self
		writeFileStreamOn: (folder / aFileNameString) fullName
		do: [:stream | stream nextPutAll: aStringOrByteArray]
		binary: aStringOrByteArray isString not