"
A GRSqueakPlatform is the Squeak implementation of GRPlatform, the Grease class that provides functionality that can not be implemented in a platform independent way.

"
Class {
	#name : 'GRSqueakPlatform',
	#superclass : 'GRPharoPlatform',
	#classVars : [
		'UrlTable',
		'XmlTable'
	],
	#category : 'Grease-Squeak6-Core',
	#package : 'Grease-Squeak6-Core'
}

{ #category : 'class initialization' }
GRSqueakPlatform class >> initialize [
	self initializeXmlTable.
	self initializeUrlTable.
	self select
]

{ #category : 'class initialization' }
GRSqueakPlatform class >> initializeUrlTable [
	UrlTable := ByteArray new: 256.
	1 to: 256 do: [ :index |
		('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_.~' includes: (Character codePoint: index - 1))
			ifTrue: [ UrlTable at: index put: 0 ]
			ifFalse: [ UrlTable at: index put: 1 ] ]
]

{ #category : 'class initialization' }
GRSqueakPlatform class >> initializeXmlTable [
	XmlTable := ByteArray new: 256.
	1 to: 256 do: [ :index |
		('"<&>' includes: (Character codePoint: index - 1))
			ifTrue: [ XmlTable at: index put: 1 ]
			ifFalse: [ XmlTable at: index put: 0 ] ]
]

{ #category : 'class initialization' }
GRSqueakPlatform class >> unload [
	self unselect
]

{ #category : 'startup' }
GRSqueakPlatform >> addToShutDownList: anObject [
	"Add anObject to the shutdown-list of the system. On shutdown the message #shutDown will be sent to anObject."

	Smalltalk addToShutDownList: anObject
]

{ #category : 'startup' }
GRSqueakPlatform >> addToStartUpList: anObject [
	"Add anObject to the startup-list of the system. On startup the message #startUp will be sent to anObject."

	Smalltalk addToStartUpList: anObject
]

{ #category : 'file library' }
GRSqueakPlatform >> asMethodReturningByteArray: aByteArrayOrString named: aSymbol [
	"Generates the source of a method named aSymbol that returns aByteArrayOrString as a ByteArray"
	^ self useByteArrayLiterals
		ifTrue: [ self asMethodReturningByteArrayLiteral: aByteArrayOrString named: aSymbol ]
		ifFalse: [ self asMethodReturningByteArrayWithCache: aByteArrayOrString named: aSymbol ]
]

{ #category : 'private-file library' }
GRSqueakPlatform >> asMethodReturningByteArrayLiteral: aByteArrayOrString named: aSymbol [
	"Generates the source of a method named aSymbol that returns aByteArrayOrString as a byte array using VW/NewCompiler byte array literal syntax."
	^ String streamContents: [ :stream |
		stream nextPutAll: aSymbol; nextPut: Character cr.
		stream tab; nextPutAll: '^ #['.
		aByteArrayOrString asByteArray
			do: [ :each | each printOn: stream ]
			separatedBy: [ stream space ].
		stream nextPutAll: ']' ]
]

{ #category : 'private-file library' }
GRSqueakPlatform >> asMethodReturningByteArrayWithCache: aByteArrayOrString named: aSymbol [
	"Generates the source of a method named aSymbol that returns aByteArrayOrString as a byte array and caching this array in a literal array of size 1."
	^ String streamContents: [ :stream |
		stream nextPutAll: aSymbol; nextPut: Character cr.
		stream tab; nextPutAll: '^ #('.
		aByteArrayOrString asByteArray
			do: [ :each | each printOn: stream ]
			separatedBy: [ stream space ].
		stream nextPutAll: ') asByteArray' ]
]

{ #category : 'encoding' }
GRSqueakPlatform >> base64Decode: aString [
	^ (Base64MimeConverter mimeDecodeToChars: aString readStream) contents
]

{ #category : 'encoding' }
GRSqueakPlatform >> base64Encode: aByteArray [
	^ aByteArray base64Encoded
]

{ #category : 'bindings' }
GRSqueakPlatform >> bindingOf: aClass [
	"theoretically consider the environment of a class"
	^ aClass binding
]

{ #category : 'file library' }
GRSqueakPlatform >> compile: aString into: aClass classified: aSymbol [ 
	"The trick here is to be as silently a possible so that the package is not marked dirty when running WAFileLibrary test.
	This also makes running tests much faster."
	| methodNode compiledMethod selector methodAndNode |
	methodNode := aClass compilerClass new 
		compile: aString
		in: aClass
		notifying: nil
		ifFail: [ GRError signal: 'syntax error' ].
	selector := methodNode selector.
	methodAndNode := CompiledMethodWithNode 
		generateMethodFromNode: methodNode
		trailer: aClass defaultMethodTrailer.
	compiledMethod := methodAndNode method.
	compiledMethod 
		putSource: aString
		fromParseNode: methodAndNode node
		inFile: 2
		withPreamble: [ :file | 
			aClass
				printCategoryChunk: aSymbol asString
				on: file priorMethod: (aClass compiledMethodAt: selector ifAbsent: [ nil ]).
			file cr ].
	aClass 
		addSelectorSilently: selector
		withMethod: compiledMethod.
	SystemChangeNotifier uniqueInstance doSilently:  [
		aClass organization 
			classify: selector
			under: aSymbol ]
]

{ #category : 'file library' }
GRSqueakPlatform >> contentsOfFile: aString binary: aBoolean [
	| stream |
	stream := aBoolean
		ifTrue: [ (FileDirectory default oldFileNamed: aString)
			binary;
			yourself ]
		ifFalse: [ (MultiByteFileStream oldFileNamed: aString)
			ascii;
			wantsLineEndConversion: true;
			yourself ].
	^ [ stream contents ] ensure: [ stream close ]
]

{ #category : 'file library' }
GRSqueakPlatform >> defaultDirectoryPathString [
	^ FileDirectory default fullName
]

{ #category : 'files' }
GRSqueakPlatform >> deleteFile: aPathString [
	FileDirectory deleteFilePath: aPathString
]

{ #category : 'exceptions' }
GRSqueakPlatform >> deprecationExceptionSet [
	^ Deprecation
]

{ #category : 'file library' }
GRSqueakPlatform >> directoriesIn: aPathString [
	"Return a collection of absolute paths for all the files (no directories) in the directory given by aPathString
	must not include file names that start with ."
	| directory |
	directory := FileDirectory default directoryNamed: aPathString.
	^ (directory directoryNames
		reject: [ :each | each first = $. ])
		collect: [ :each | directory fullNameFor: each ]
]

{ #category : 'private' }
GRSqueakPlatform >> doSilently: aBlock [
	^ SystemChangeNotifier uniqueInstance doSilently:  aBlock
]

{ #category : 'file library' }
GRSqueakPlatform >> ensureExistenceOfFolder: aString [
	"creates a folder named aString in the image directory"
	FileDirectory default assureExistenceOfPath: aString
]

{ #category : 'file library' }
GRSqueakPlatform >> fileExists: aString [
	^ FileDirectory default fileExists: aString
]

{ #category : 'file library' }
GRSqueakPlatform >> fileNameFor: aPathString [
	| path |
	path := FileDirectory default fullPathFor: aPathString.
	^ (path size > 1 and: [ path endsWith: FileDirectory slash ])
		ifTrue: [ path allButLast: FileDirectory slash size ]
		ifFalse: [ path ]
]

{ #category : 'file library' }
GRSqueakPlatform >> fileStreamOn: aString do: aBlock binary: aBoolean [
	^ aBoolean
		ifTrue: [
			FileStream fileNamed: aString do: [ :stream |
				stream binary.
				aBlock value: stream ] ]
		ifFalse: [
			MultiByteFileStream fileNamed: aString do: [ :stream |
				stream
					ascii;
					wantsLineEndConversion: true.
					aBlock value: stream ] ]
]

{ #category : 'file library' }
GRSqueakPlatform >> filesIn: aPathString [
	"Return a collection of absolute paths for all the files (no directories) in the directory given by aPathString
	must not include file names that start with ."
	| directory |
	directory := FileDirectory default directoryNamed: aPathString.
	^ (directory fileNames
		reject: [ :each | each first = $. ])
		collect: [ :each | directory fullNameFor: each ]
]

{ #category : 'encoding' }
GRSqueakPlatform >> integerAsByteArray: anInteger [
	| size array |
	size := anInteger greaseBytesCount.
	array := ByteArray new: size.
	size to: 1 by: -1 do: [ :digitIndex |
		array
			at: size - digitIndex + 1
			put: (anInteger greaseByteAt: digitIndex) ].
	^ array
]

{ #category : 'file library' }
GRSqueakPlatform >> isDirectory: aPathString [
	^ (FileDirectory forFileName: aPathString) directoryEntry isDirectory
]

{ #category : 'processes' }
GRSqueakPlatform >> isProcessTerminated: aProcess [
	"Return a boolean indicating whether aProcess has been terminated."
	^ aProcess isTerminated
]

{ #category : 'version info' }
GRSqueakPlatform >> label [
	^ 'Squeak'
]

{ #category : 'file library' }
GRSqueakPlatform >> localNameOf: aFilename [
	^ (FileDirectory on: aFilename) localName
]

{ #category : 'factory' }
GRSqueakPlatform >> newRandom [
	"Answers the random number generator to be used to create session and continuation keys. Make sure it is seeded. They only methods that will be sent to it are:
	  #nextInt: - should answer a random integer in the interval [1, anInteger]
	  #randomFrom: - should answer a random element from the given collection
	
	Make sure that both methods are safe under heavy concurrent load.
	
	Used by Gemstone/S traditional Randoms which cannot be persisted.."
	^ ThreadSafeRandom value
]

{ #category : 'files' }
GRSqueakPlatform >> newTemporaryFile [

	^ self newTemporaryFileNamed: UUID new greaseString
]

{ #category : 'files' }
GRSqueakPlatform >> newTemporaryFileNamed: aName [

	| file |
	file := FileDirectory default / aName.
	file exists ifTrue: [ GRError new signal: 'A (temporary) file with name ', aName, ' already exists.' ].
	^ file pathName
]

{ #category : 'file library' }
GRSqueakPlatform >> newline [
	^ String with: Character cr
]

{ #category : 'exceptions' }
GRSqueakPlatform >> openDebuggerOn: anError [
	"Squeak variant based on the Pharo platform code, intended to avoid the deprecated #debug:title:full: message"

	ToolSet handleError: anError
]

{ #category : 'files' }
GRSqueakPlatform >> pathSeparator [
	^ String with: FileDirectory pathNameDelimiter
]

{ #category : 'files' }
GRSqueakPlatform >> readFileStreamOn: aString do: aBlock binary: aBoolean [
	^ aBoolean
		ifTrue: [
			FileStream fileNamed: aString do: [ :stream |
				stream binary.
				aBlock value: stream ] ]
		ifFalse: [
			MultiByteFileStream fileNamed: aString do: [ :stream |
				stream
					ascii;
					wantsLineEndConversion: true.
					aBlock value: stream ] ]
]

{ #category : 'factory' }
GRSqueakPlatform >> readWriteByteStream [
	"ByteArray based read write stream"
	
	^ RWBinaryOrTextStream on: (ByteArray new: 4096)
]

{ #category : 'factory' }
GRSqueakPlatform >> readWriteCharacterStream [
	"String based read write stream"

	^ ReadWriteStream on: (String new: 4096)
]

{ #category : 'startup' }
GRSqueakPlatform >> removeFromShutDownList: anObject [
	"Remove anObject from the shutdown list in the system."

	Smalltalk removeFromShutDownList: anObject
]

{ #category : 'startup' }
GRSqueakPlatform >> removeFromStartUpList: anObject [
	"Remove anObject from the startup list in the system."

	Smalltalk removeFromStartUpList: anObject
]

{ #category : 'file library' }
GRSqueakPlatform >> removeSelector: aSymbol from: aClass [
	aClass removeSelectorSilently: aSymbol
]

{ #category : 'cryptography' }
GRSqueakPlatform >> secureHashFor: aString [
	^ SecureHashAlgorithm new hashMessage: aString
]

{ #category : 'factory' }
GRSqueakPlatform >> semaphoreClass [
	"used by Gemstone/S traditional Semaphores which cannot be persisted"
	^ Semaphore
]

{ #category : 'files' }
GRSqueakPlatform >> sizeOfFile: aString [

	^ aString asDirectoryEntry fileSize
]

{ #category : 'meta-object-protocol' }
GRSqueakPlatform >> sourceCodeStringOf: aCompiledMethod [
	"Return a String with the source code for a compiled method."

	^ self convertToSmalltalkNewlines: aCompiledMethod getSourceFromFile
]

{ #category : 'exceptions' }
GRSqueakPlatform >> stackDepth [
	<ignoreForCoverage>
	| depth current |
	depth := 0.
	current := thisContext.
	[ current isNil ] whileFalse: [
		current := current sender.
		depth := depth + 1 ].
	^ depth - 1
]

{ #category : 'processes' }
GRSqueakPlatform >> terminateProcess: aProcess [
	"Permanently terminate the process, unwinding first to execute #ensure: and #ifCurtailed: blocks."
	aProcess terminate
]

{ #category : 'processes' }
GRSqueakPlatform >> thisContext [
	<ignoreForCoverage>
	^ thisContext sender
]

{ #category : 'private-file library' }
GRSqueakPlatform >> useByteArrayLiterals [
	"whether ByteArray literals can/should be used"
	| hasSettings |
	hasSettings := Smalltalk at: #PragmaSetting ifAbsent: [ nil ].
	^ hasSettings isNil
		ifTrue: [
			(Smalltalk at: #Preferences)
				valueOfFlag: #compileUseNewCompiler
				ifAbsent: [ false ] ]
		ifFalse: [ false ]
]

{ #category : 'factory' }
GRSqueakPlatform >> weakDictionaryOfSize: aNumber [
	^ IdentityDictionary new: aNumber
]

{ #category : 'file library' }
GRSqueakPlatform >> write: aStringOrByteArray toFile: aFileNameString inFolder: aFolderString [
	"writes aStringOrByteArray to a file named aFilenameString in the folder aFolderString"
	| folder stream fullFilePath |
	folder := FileDirectory default directoryNamed: aFolderString.
	fullFilePath := folder fullNameFor: aFileNameString.
	stream := aStringOrByteArray isString
		ifTrue: [		
			(MultiByteFileStream forceNewFileNamed: fullFilePath)
				ascii;
				wantsLineEndConversion: true;
				yourself ]
		ifFalse: [ (FileStream forceNewFileNamed: fullFilePath) binary ].
	[ stream nextPutAll: aStringOrByteArray ]
		ensure: [ stream close ]
]

{ #category : 'files' }
GRSqueakPlatform >> writeFileStreamOn: aString do: aBlock binary: aBoolean [ 
	| stream |
	stream := aBoolean
				ifTrue: [ (FileStream fileNamed: aString) binary ]
				ifFalse: [ (MultiByteFileStream fileNamed: aString) ascii; wantsLineEndConversion: true; yourself ].
	[ aBlock value: stream ]
		ensure: [ stream close ]
]
