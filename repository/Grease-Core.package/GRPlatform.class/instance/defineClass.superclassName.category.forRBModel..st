tests
defineClass: aClassSymbol superclassName: aSuperSymbol category: aString forRBModel: aModel
	^ aModel defineClass: aSuperSymbol , ' subclass: #' , aClassSymbol , '
		instanceVariableNames: '''' 
		classVariableNames: ''''
		poolDictionaries: ''''
		category: ''' , aString , ''''