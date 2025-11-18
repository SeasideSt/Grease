Class {
	#name : 'GRPharoPlatformTest',
	#superclass : 'TestCase',
	#category : 'Grease-Tests-Pharo-Core',
	#package : 'Grease-Tests-Pharo-Core'
}

{ #category : 'running' }
GRPharoPlatformTest >> runCase [
	GRPharoPlatform current doSilently:  [ super performTest ]
]

{ #category : 'tests' }
GRPharoPlatformTest >> testCompileIntoClassified [
	| source protocol selectors selector |
	source := 'aMethod
	^ ''a result'''.
	protocol := 'a-protocol'.
	selector := #aMethod.
	GRPlatform current 
		compile: source
		into: self class
		classified: protocol.
	
	[ self assert: (self class selectors includes: selector).
	selectors := self class selectorsInProtocol: protocol.
	self assert: selectors = (Array with: selector) ] ensure: [ self class removeSelector: selector ]
]

{ #category : 'tests' }
GRPharoPlatformTest >> testDeprecationExceptionSet [
	| value |
	value := [
		"intentially send Pharo instead of Grease deprecation message"
		self deprecated: 'test'.
		'failed' ]
			on: GRDeprecatedApiNotification, GRPlatform current deprecationExceptionSet
			do: [ :e | 'passed' ].
	self assert: value = 'passed'
]

{ #category : 'tests' }
GRPharoPlatformTest >> testFullName [
	self assert: Object fullName = 'Object'
]

{ #category : 'tests' }
GRPharoPlatformTest >> testGreaseIntegerOnCharacter [
	| character |
	character := Character codePoint: 19982.
	self assert: character greaseInteger = 19982.
	character := Unicode value: 19982.
	self assert: character greaseInteger = 19982
]

{ #category : 'tests' }
GRPharoPlatformTest >> testMessageSendValueWithPossibleArguments [
	| send |
	send := MessageSend receiver: 1 selector: #+.
	self assert: (send valueWithPossibleArguments: (Array with: 2)) = 3.
	self assert: (send valueWithArguments: (Array with: 2)) = 3.
	self assert: (send value: 2) = 3.

	send := MessageSend receiver: false selector: #not.
	self assert: (send valueWithPossibleArguments: (Array with: 3)).
	
	send := MessageSend receiver: 1 selector: #+ arguments: #(2).
	self assert: (send valueWithPossibleArguments: (Array with: 4)) = 3.
	self assert: send value = 3.
	
	send := MessageSend receiver: Array selector: #with:with: arguments: #(1).
	self assert: (send valueWithPossibleArguments: (Array with: 2)) size = 2.

	send := MessageSend receiver: Array selector: #with:with:.
	self assert: (send value: 1 value: 2) size = 2.
	
	send := MessageSend 
		receiver: 1
		selector: #+.
	self assert: send argumentCount = 1.
	self assert: send arguments size = 0.
	
	send := MessageSend 
		receiver: 1
		selector: #+
		argument: 2.
	self assert: send argumentCount isZero.
	self assert: send arguments size = 1
]

{ #category : 'tests-filestreams' }
GRPharoPlatformTest >> testReadWriteToFileInFolderTextUTF8 [
	#('Übèrstrîñgé' '£ęλ~') do:[ :text | 
		self 
			writeToFile: text 
			withFileNameDo:[ :fileName |
				self assert: text equals: (GRPlatform current contentsOfFile: fileName binary: false) ] ].
]

{ #category : 'tests' }
GRPharoPlatformTest >> testUseByteArrayLiterals [
	| useByteArrayLiterals |
	useByteArrayLiterals := GRPlatform current useByteArrayLiterals.
	self assert: (useByteArrayLiterals or: [ useByteArrayLiterals not ])
]

{ #category : 'private' }
GRPharoPlatformTest >> writeToFile: aStringOrByteArray withFileNameDo: aBlock [
	| fileName directory |
	fileName :=  'GRPharoPlatformTest'.
	directory := FileSystem disk workingDirectory.
	[ GRPlatform current
		write: aStringOrByteArray
		toFile: fileName
		inFolder: directory fullName.
	aBlock value: directory fullName,GRPlatform current pathSeparator,fileName
		] ensure: [
			(directory / fileName) delete ]
]
