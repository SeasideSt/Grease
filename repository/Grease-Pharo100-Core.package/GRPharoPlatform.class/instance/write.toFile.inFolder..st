file library
write: aStringOrByteArray toFile: aFileNameString inFolder: aFolderString
	"writes aStringOrByteArray to a file named aFilenameString in the folder aFolderString"
	^ self
		writeFileStreamOn: (aFolderString asFileReference / aFileNameString) ensureDelete pathString
		do: [ :stream | stream nextPutAll: aStringOrByteArray ]
		binary: aStringOrByteArray isString not