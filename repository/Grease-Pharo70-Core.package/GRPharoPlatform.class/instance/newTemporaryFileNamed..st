files
newTemporaryFileNamed: aName

	| newFile |
	newFile := FileLocator temp / aName.
	newFile exists ifTrue: [ GRError new signal: 'A (temporary) file with name ', aName, ' already exists.' ].
	^ newFile pathString