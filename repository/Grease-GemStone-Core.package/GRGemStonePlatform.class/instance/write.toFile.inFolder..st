file-library
write: aStringOrByteArray toFile: aFileNameString inFolder: aFolderString
  "writes aStringOrByteArray to a file named aFilenameString in the folder aFolderString"

  | folder fullFilePath |
  fullFilePath := ServerFileDirectory default fullNameFor: aFolderString.
  folder := ServerFileDirectory on: fullFilePath.
  (folder fileExists: aFileNameString)
    ifTrue: [ folder deleteFileNamed: aFileNameString ].
  ^ self
    writeFileStreamOn: (folder / aFileNameString) fullName
    do: [ :stream | stream nextPutAll: aStringOrByteArray ]
    binary: aStringOrByteArray isString not