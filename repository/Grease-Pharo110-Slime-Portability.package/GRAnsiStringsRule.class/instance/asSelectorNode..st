private
asSelectorNode: aSymbol
	^ (Smalltalk hasClassNamed: #OCSelectorNode)
		ifTrue: [ (Smalltalk classNamed: #OCSelectorNode) value: aSymbol ]
		ifFalse: [ aSymbol ]