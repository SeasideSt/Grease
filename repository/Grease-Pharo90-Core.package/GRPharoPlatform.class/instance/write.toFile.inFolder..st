file library
write: aStringOrByteArray toFile: aFileNameString inFolder: aFolderString
	"writes aStringOrByteArray to a file named aFilenameString in the folder aFolderString"

	| folder |
	folder := FileSystem disk resolveString: aFolderString.
	"TODO: wantsLineEndConversion: true; ??"
	^ self
		writeFileStreamOn: (folder / aFileNameString) asFileReference ensureDelete fullName
		do: [ :stream | stream nextPutAll: aStringOrByteArray ]
		binary: aStringOrByteArray isString not