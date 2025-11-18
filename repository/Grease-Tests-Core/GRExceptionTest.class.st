Class {
	#name : 'GRExceptionTest',
	#superclass : 'TestCase',
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'private' }
GRExceptionTest >> onExceptionReturn: anObject [
	[ GRError signal ]
		on: GRError
		do: [ :ex | ^ anObject ].
	
	^ self
]

{ #category : 'tests' }
GRExceptionTest >> testDefaultActionResume [
	"According to ANSI 5.5.15.2, the result of #defaultAction
	should be used to resume resumable exceptions. Behaviour is undefined
	for non-resumable exceptions so we do not test for that case."
	
	| result |
	result := GRNotificationStub signal.
	self assert: result = #returnValue
]

{ #category : 'tests' }
GRExceptionTest >> testDeprecatedApi [
	| exception seen |
	exception := seen := nil.
	
	[ self 
		greaseDeprecatedApi: 'GRExceptionTest>>#testDeprecatedApi'
		details: 'Message in a bottle.'.
	seen := true ] 
		on: GRDeprecatedApiNotification
		do: 
			[ :notification | 
			exception := notification.
			exception resume.
			seen := false ].
	self assert: seen.
	self assert: exception notNil.
	self assert: exception messageText = 'GRExceptionTest>>#testDeprecatedApi'.
	self assert: exception details = 'Message in a bottle.'
]

{ #category : 'tests' }
GRExceptionTest >> testErrorInitialization [
	"Make sure #initialize is called on #new and that calling 'super initialize' doesn't error."
	self assert: GRErrorStub new foo
]

{ #category : 'tests' }
GRExceptionTest >> testIsResumable [
	"Make sure the platform class provides #isResumable on Exception.
	This test made a bit more complex by James Foster per issue #259
	for GemStone portability."

	| exception |
	[ Exception signal ]
		on: Exception
		do: [ :ex | 
			exception := ex.
			ex return
	].
	self shouldnt: [ exception isResumable ] raise: MessageNotUnderstood
]

{ #category : 'tests' }
GRExceptionTest >> testNotificationInitialization [
	"Make sure #initialize is called on #new and that calling 'super initialize' doesn't error."
	self assert: GRNotificationStub new foo
]

{ #category : 'tests' }
GRExceptionTest >> testOnDoImplicitReturn [
	"According to ANSI 5.5.15.2, an exception handler block that runs to completion
	should result in the call to #on:do: returning the block's value."
	
	| result |
	result := [ GRErrorStub signal ] on: GRErrorStub do: [ :e | #blockValue ].
	self assert: result = #blockValue.
	
	result := nil.
	result := [ GRNotificationStub signal ] on: GRNotificationStub do: [ :e | #blockValue ].
	self assert: result = #blockValue
]

{ #category : 'tests' }
GRExceptionTest >> testOnDoNonLocalReturn [
	"You should be able to do a non-local return from within an exception
	handler block. We rely on a helper method here so we can check the return
	value."
	
	self assert: (self onExceptionReturn: 123) == 123
]

{ #category : 'tests' }
GRExceptionTest >> testSignalError [
	"Exception>>signal is part of the ANSI Smalltalk standard. However, Seaside
	only signals subclasses of GRError and GRNotification so Smalltalk
	implementations that do not otherwise provide it can implement it on
	these two classes."
	[ GRError new signal ] 
		on: GRError
		do: [ :e | ^ self ].
	self assert: false
]

{ #category : 'tests' }
GRExceptionTest >> testSignalErrorClassSide [
	"Exception class>>signal is part of the ANSI Smalltalk standard. However, Seaside
	only signals subclasses of GRError and GRNotification so Smalltalk
	implementations that do not otherwise provide it can implement it on
	these two classes."
	[ GRError signal ] 
		on: GRError
		do: [ :e | ^ self ].
	self assert: false
]

{ #category : 'tests' }
GRExceptionTest >> testSignalNotification [
	"Exception>>signal is part of the ANSI Smalltalk standard. However, Seaside
	only signals subclasses of GRError and GRNotification so Smalltalk
	implementations that do not otherwise provide it can implement it on
	these two classes."
	[ GRNotification new signal ] 
		on: GRNotification
		do: [ :e | ^ self ].
	self assert: false
]

{ #category : 'tests' }
GRExceptionTest >> testSignalNotificationClassSide [
	"Exception class>>signal is part of the ANSI Smalltalk standard. However, Seaside
	only signals subclasses of GRError and GRNotification so Smalltalk
	implementations that do not otherwise provide it can implement it on
	these two classes."
	[ GRNotification signal ] 
		on: GRNotification
		do: [ :e | ^ self ].
	self assert: false
]

{ #category : 'tests' }
GRExceptionTest >> testSignalWithError [
	"Exception>>signal: is part of the ANSI Smalltalk standard. However, Seaside
	only signals subclasses of GRError and GRNotification so Smalltalk
	implementations that do not otherwise provide it can implement it on
	these two classes."
	| text |
	text := 'Error!'.
	[ GRError new signal: text ] 
		on: GRError
		do: 
			[ :e | 
			self assert: e messageText = text.
			^ self ].
	self assert: false
]

{ #category : 'tests' }
GRExceptionTest >> testSignalWithErrorClassSide [
	"Exception class>>signal: is part of the ANSI Smalltalk standard. However, Seaside
	only signals subclasses of GRError and GRNotification so Smalltalk
	implementations that do not otherwise provide it can implement it on
	these two classes."
	| text |
	text := 'Error!'.
	[ GRError signal: text ] 
		on: GRError
		do: 
			[ :e | 
			self assert: e messageText = text.
			^ self ].
	self assert: false
]

{ #category : 'tests' }
GRExceptionTest >> testSignalWithNotification [
	"Exception>>signal: is part of the ANSI Smalltalk standard. However, Seaside
	only signals subclasses of GRError and GRNotification so Smalltalk
	implementations that do not otherwise provide it can implement it on
	these two classes."
	| text |
	text := 'Notification'.
	[ GRNotification new signal: text ] 
		on: GRNotification
		do: 
			[ :e | 
			self assert: e messageText = text.
			^ self ].
	self assert: false
]

{ #category : 'tests' }
GRExceptionTest >> testSignalWithNotificationClassSide [
	"Exception class>>signal: is part of the ANSI Smalltalk standard. However, Seaside
	only signals subclasses of GRError and GRNotification so Smalltalk
	implementations that do not otherwise provide it can implement it on
	these two classes."
	| text |
	text := 'Notification'.
	[ GRNotification signal: text ] 
		on: GRNotification
		do: 
			[ :e | 
			self assert: e messageText = text.
			^ self ].
	self assert: false
]
