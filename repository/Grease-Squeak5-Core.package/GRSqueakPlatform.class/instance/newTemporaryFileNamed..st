files
newTemporaryFileNamed: aName

	| file |
	file := FileDirectory default / aName.
	file exists ifTrue: [ GRError new signal: 'A (temporary) file with name ', aName, ' already exists.' ].
	^ file pathName