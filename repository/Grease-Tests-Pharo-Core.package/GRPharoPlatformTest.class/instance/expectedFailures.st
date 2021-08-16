running
expectedFailures
	"UTF8 encoding/decoding for text files only available from Pharo7"
	Smalltalk at: #SystemVersion ifPresent: [ :systemVersion |
		| versionString |
		versionString := systemVersion current version.
		(versionString beginsWith: 'Pharo') ifTrue: [
			systemVersion current major <= 7
				ifTrue: [ ^ #(testReadWriteToFileInFolderTextUTF8) ] ] ].
	^ #()