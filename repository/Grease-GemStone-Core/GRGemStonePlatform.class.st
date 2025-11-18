Class {
	#name : 'GRGemStonePlatform',
	#superclass : 'GRPlatform',
	#classVars : [
		'TransactionMutex'
	],
	#category : 'Grease-GemStone-Core',
	#package : 'Grease-GemStone-Core'
}

{ #category : 'class initialization' }
GRGemStonePlatform class >> initialize [
	self select.
	self current transactionMutex	"http://code.google.com:9393/p/glassdb/issues/detail?id=290 	transactionMutex is always nil"
]

{ #category : 'class initialization' }
GRGemStonePlatform class >> unload [
	self unselect
]

{ #category : 'startup' }
GRGemStonePlatform >> addToShutDownList: anObject [
	"We'll ignore this functionality in GemStone for now"
]

{ #category : 'startup' }
GRGemStonePlatform >> addToStartUpList: anObject [
	"We'll ignore this functionality in GemStone for now"
]

{ #category : 'private-file-library' }
GRGemStonePlatform >> asMethodReturningByteArray: aByteArrayOrString named: aSymbol [
	"Generates the source of a method named aSymbol that returns aByteArrayOrString as a byte array."

	^ String streamContents: [ :stream |
		stream nextPutAll: aSymbol , '

	^#('.
		aByteArrayOrString asByteArray
			do: [ :each | each printOn: stream ]
			separatedBy: [ stream space ].
		stream nextPutAll: ') asByteArray.'; cr.
	].
]

{ #category : 'private-file-library' }
GRGemStonePlatform >> asMethodReturningString: aByteArrayOrString named: aSymbol [
	"Generates the source of a method named aSymbol that returns aByteArrayOrString as a string."
	^String streamContents: [ :stream |
		stream nextPutAll: aSymbol; nextPut: Character cr.
		stream tab; nextPutAll: '^ '''.
		aByteArrayOrString greaseString do: 
			[ :each | 
			each = $' ifTrue: [ stream nextPut: $' ].
			stream nextPut: each ].
		stream nextPutAll: '''' ]
]

{ #category : 'encoding' }
GRGemStonePlatform >> base64Decode: aString [
	^ (Base64MimeConverter mimeDecodeToChars: aString readStream) contents
]

{ #category : 'encoding' }
GRGemStonePlatform >> base64Encode: aByteArray [
	^ (Base64MimeConverter mimeEncode: aByteArray readStream) contents
]

{ #category : 'file-library' }
GRGemStonePlatform >> compile: aString into: aClass classified: aSymbol [

	| result |
	result := aClass
		compileMethod: aString
		dictionaries: System myUserProfile symbolList
		category: aSymbol.
	result isNil ifTrue: [^self].
	self error: 'not yet implemented!'.
]

{ #category : 'files' }
GRGemStonePlatform >> contentsOfFile: aString binary: aBoolean [
	^ self fileStreamOn: aString do: [ :stream | stream contents ] binary: aBoolean
]

{ #category : 'dispatchers' }
GRGemStonePlatform >> defaultDispatcherName [
	^'seaside'
]

{ #category : 'files' }
GRGemStonePlatform >> deleteFile: aPathString [

	GsFile removeServerFile: aPathString

]

{ #category : 'exceptions' }
GRGemStonePlatform >> deprecationExceptionSet [
	^ ExceptionSet new
]

{ #category : 'files' }
GRGemStonePlatform >> directoriesIn: aPathString [
	"Answer a collection of absolute paths for all the directories (no files) in the directory given by aPathString
	must not include directory names that start with ."
	| directory |
	directory := ServerFileDirectory on: aPathString.
	^(directory directoryNames
		reject: [ :each | each first = $. ])
		collect: [ :each | directory fullNameFor: each ]
]

{ #category : 'transactions' }
GRGemStonePlatform >> doAbortTransaction [

	SystemAbortTransaction signal.
]

{ #category : 'transactions' }
GRGemStonePlatform >> doBeginTransaction [

	SystemBeginTransaction signal.
]

{ #category : 'transactions' }
GRGemStonePlatform >> doCommitTransaction [

	System inTransaction ifTrue: [^SystemCommitTransaction signal].
	^true
]

{ #category : '*grease-gemstone-core' }
GRGemStonePlatform >> doTransaction: aBlock [
  "Evaluate aBlock in a transaction. 
	 Return true if the transaction succeeds and false if the transaction fails.
	 Nested calls are allowed and will always return true.
	 See System class>>transactionConflicts for dealing with failed transactions."

  "Ensure that each block evaluation is mutually exclusive: https://code.google.com/p/glassdb/issues/detail?id=355"

  self transactionMutex
    critical: [ 
      | commitResult |
      "Get the transactionMutex, and perform the transaction."
      System inTransaction
        ifTrue: [ 
          "We already are in a transaction, so just evaluate the block"
          aBlock value.
          ^ true ]
        ifFalse: [ 
          [ 
          self doBeginTransaction.
          aBlock value ]
            ensure: [ 
              "workaround for Bug 42963: ensure: block executed twice (don't return from ensure: block)"
              commitResult := self doCommitTransaction ] ].
      ^ commitResult ]
]

{ #category : 'files' }
GRGemStonePlatform >> ensureExistenceOfFolder: aString [
	"creates a folder named aString in the default server directory"
	ServerFileDirectory default assureExistenceOfPath: aString
]

{ #category : 'files' }
GRGemStonePlatform >> fileExists: aString [
	^ GsFile existsOnServer: aString
]

{ #category : 'files' }
GRGemStonePlatform >> filesIn: aPathString [
	"Return a collection of absolute paths for all the files (no directories) in the directory given by aPathString
	must not include file names that start with ."
	| directory |
	directory := ServerFileDirectory on: aPathString.
	^(directory fileNames
		reject: [ :each | each first = $. ])
		collect: [ :each | directory fullNameFor: each ]
]

{ #category : 'processes' }
GRGemStonePlatform >> isProcessTerminated: aGsProcess [

	^aGsProcess _isTerminated.
]

{ #category : 'version info' }
GRGemStonePlatform >> label [

	^'GemStone'
]

{ #category : 'files' }
GRGemStonePlatform >> localNameOf: aFilename [
	^(ServerFileDirectory on: aFilename) localName
]

{ #category : 'services' }
GRGemStonePlatform >> logError: aDescription title: aString [

	self logError: aDescription title: aString shouldCommit: false
]

{ #category : 'services' }
GRGemStonePlatform >> logError: aDescription title: aString shouldCommit: shouldCommit [

	| stdout stack logStream |
	stack := GsProcess stackReportToLevel: 300.
	self saveLogEntry: (ObjectLogEntry error: aString object: { aDescription. stack. }) shouldCommit: shouldCommit.
	stdout := GsFile stdoutServer.
	stdout nextPutAll: '----------- ', aString, ' ERROR Encountered: ', DateAndTime now printString.
	stdout cr.
	stdout nextPutAll: aDescription.
	stdout cr.
	stdout nextPutAll: stack.
	stdout nextPutAll: '-----------'.
	stdout cr.
	stdout close.
]

{ #category : 'factory' }
GRGemStonePlatform >> newRandom [	
	"Answers the random number generator to be used to create session and continuation keys. Make sure it is seeded. They only methods that will be sent to it are:
		#nextInt: - should answer a random integer in the interval [1, anInteger]
		#randomFrom: - should answer a random element from the given collection

	 Make sure that both methods are safe under heavy concurrent load.
	
	 Used by Gemstone/S traditional Randoms which cannot be persisted."	

	^ GRGemStoneRandomProvider
]

{ #category : 'files' }
GRGemStonePlatform >> newTemporaryFile [

	^ self newTemporaryFileNamed: UUID new greaseString

]

{ #category : 'files' }
GRGemStonePlatform >> newTemporaryFileNamed: aName [

	| fileName |
	fileName := GRPlatform current pathSeparator,'tmp', GRPlatform current pathSeparator, aName.
	(self fileExists: fileName) ifTrue: [ GRError new signal: 'A (temporary) file with name ', aName, ' already exists.' ].
	^ (GsFile openWriteOnServer: fileName) pathName

]

{ #category : 'file-library' }
GRGemStonePlatform >> newline [

	^String lf
]

{ #category : 'exceptions' }
GRGemStonePlatform >> openDebuggerOn: anError [

	^self generateHardBreak.
]

{ #category : 'files' }
GRGemStonePlatform >> pathSeparator [
	^ FileDirectory pathNameDelimiter asString
]

{ #category : 'files' }
GRGemStonePlatform >> readFileStreamOn: aString do: aBlock binary: aBoolean [
  | stream dir file |
  [ 
  file := GsFile openReadOnServer: aString.
  [ 
  stream := RWBinaryOrTextStream on: file contents.
  aBoolean
    ifTrue: [ stream binary ]
    ifFalse: [ stream ascii ].
  ^ aBlock value: stream ]
    ensure: [ stream close ] ]
    ensure: [ file close ]
]

{ #category : 'factory' }
GRGemStonePlatform >> readWriteByteStream [
	^ AnsiReadWriteStream on: ByteArray new.
]

{ #category : 'factory' }
GRGemStonePlatform >> readWriteCharacterStream [
	^ AnsiReadWriteStream on: String new.
]

{ #category : 'factory' }
GRGemStonePlatform >> reducedConflictDictionary [
	"used by Gemstone/S reduced conflict classes that can be used to avoid transaction conflicts"
	^RcKeyValueDictionary
]

{ #category : 'startup' }
GRGemStonePlatform >> removeFromShutDownList: anObject [
	"We'll ignore this functionality in GemStone for now"
]

{ #category : 'startup' }
GRGemStonePlatform >> removeFromStartUpList: anObject [
	"We'll ignore this functionality in GemStone for now"
]

{ #category : 'file-library' }
GRGemStonePlatform >> removeSelector: aSymbol from: aClass [
	aClass removeSelectorSilently: aSymbol
]

{ #category : 'services' }
GRGemStonePlatform >> saveLogEntry: anObjectLogEntry shouldCommit: shouldCommit [
	"Does an abort and commit, if not already in transaction"
	
	| stdout |
	stdout := GsFile stdoutServer.
	stdout nextPutAll: '----------- ', anObjectLogEntry labelString, ' LOG ENTRY: ', anObjectLogEntry objectString.
	stdout nextPutAll: '-----------'.
	stdout cr.
	stdout close.
	shouldCommit  
		ifTrue: [ self doTransaction: [ anObjectLogEntry addToLog ]]
		ifFalse: [ anObjectLogEntry addToLog ].
]

{ #category : 'cryptography' }
GRGemStonePlatform >> secureHashFor: aString [

	^ SecureHashAlgorithm new hashMessage: aString
]

{ #category : 'factory' }
GRGemStonePlatform >> semaphoreClass [
	"used by Gemstone/S traditional Semaphores which cannot be persisted"
	^TransientSemaphore
]

{ #category : 'files' }
GRGemStonePlatform >> sizeOfFile: aPathString [

	^ GsFile sizeOfOnServer: aPathString
]

{ #category : 'private-email' }
GRGemStonePlatform >> smtpServer [
	self error: 'not yet implemented!'.
	"^ MailSender smtpServer"
]

{ #category : 'meta-object-protocol' }
GRGemStonePlatform >> sourceCodeStringOf: aCompiledMethod [
	"Return a String with the source code for a compiled method."

	^ self convertToSmalltalkNewlines: aCompiledMethod _sourceString
]

{ #category : 'exceptions' }
GRGemStonePlatform >> stackDepth [

	| i |
	i := 1.
	[(GsProcess _frameContentsAt: i) notNil]
		whileTrue: [i := i + 1].
	^i - 1.
]

{ #category : 'processes' }
GRGemStonePlatform >> terminateProcess: aGsProcess [

	aGsProcess terminate.
]

{ #category : '*grease-gemstone-core' }
GRGemStonePlatform >> thisContext [
  ^ GsContext fromLevel: 3
]

{ #category : 'transactions' }
GRGemStonePlatform >> transactionMutex [
	"Use the TransientRecursionLock, so that nested calls within same process
	 won't cause deadlock."

	TransactionMutex ifNil: [ TransactionMutex := TransientRecursionLock new ].
	^TransactionMutex
]

{ #category : 'factory' }
GRGemStonePlatform >> weakDictionaryOfSize: aNumber [
	^IdentityDictionary new: aNumber
]

{ #category : 'files' }
GRGemStonePlatform >> write: aStringOrByteArray toFile: aFileNameString inFolder: aFolderString [
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
]

{ #category : 'transactions' }
GRGemStonePlatform >> writeCharacterStreamOn: aString [
  "String based write stream"

  ^ AnsiWriteStream on: aString
]

{ #category : 'files' }
GRGemStonePlatform >> writeFileStreamOn: fileName do: aBlock binary: isBinary [
  | stream |
  stream := BinaryOrTextFile open: fileName mode: 'w+b' onClient: false.
  stream := isBinary
    ifTrue: [ stream binary ]
    ifFalse: [ stream ascii ].
  [ aBlock value: stream ]
    ensure: [ stream close ]
]
