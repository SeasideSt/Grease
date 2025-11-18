Class {
	#name : 'GRSqueakPlatformTest',
	#superclass : 'TestCase',
	#category : 'Grease-Tests-Squeak6-Core',
	#package : 'Grease-Tests-Squeak6-Core'
}

{ #category : 'tests' }
GRSqueakPlatformTest >> testCompileIntoClassified [
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
	selectors := self class organization listAtCategoryNamed: protocol.
	self assert: selectors = (Array with: selector) ] ensure: [ self class removeSelectorSilently: selector ]
]

{ #category : 'tests' }
GRSqueakPlatformTest >> testDeprecationExceptionSet [
	| value |
	value := [
		"intentially send Squeak instead of Grease deprecation message"
		self deprecated: 'test'.
		'failed' ]
			on: GRDeprecatedApiNotification, GRPlatform current deprecationExceptionSet
			do: [ :e | 'passed' ].
	self assert: value = 'passed'
]

{ #category : 'tests' }
GRSqueakPlatformTest >> testFullName [
	self assert: Object fullName = 'Object'
]

{ #category : 'tests' }
GRSqueakPlatformTest >> testGreaseIntegerOnCharacter [
	| character |
	character := Character codePoint: 19982.
	self assert: character greaseInteger = 19982.
	character := Unicode value: 19982.
	self assert: character greaseInteger = 19982.
	LanguageEnvironment allSubclassesDo: [ :each | 
		(each class selectors includes: #leadingChar) ifTrue: [
			"fuck me gently with a chainsaw"
			character := Character 
				leadingChar: each leadingChar
				code: 19982.
			self assert: character greaseInteger = 19982 ] ]
]

{ #category : 'tests' }
GRSqueakPlatformTest >> testMessageSendValueWithPossibleArguments [
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

{ #category : 'tests' }
GRSqueakPlatformTest >> testWriteToFileInFolderBinary [
	self writeToFile: #[80 104 39 110 103 108 117 105 32 109 103 108 119 39 110 97 102 104 32 67 116 104 117 108 104 117 32 82 39 108 121 101 104 32 119 103 97 104 39 110 97 103 108 32 102 104 116 97 103 110]
]

{ #category : 'tests' }
GRSqueakPlatformTest >> testWriteToFileInFolderText [
	self writeToFile: 'Ph''nglui mglw''nafh Cthulhu R''lyeh wgah''nagl fhtagn'
]

{ #category : 'private' }
GRSqueakPlatformTest >> writeToFile: aStringOrByteArray [
	| fileName directory |
	fileName :=  'GRPharoPlatformTest'.
	directory := FileDirectory default.
	[ GRPlatform current
		write: aStringOrByteArray
		toFile: fileName
		inFolder: directory pathName
		] ensure: [
			directory deleteFileNamed: fileName ]
]
