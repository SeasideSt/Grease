Class {
	#name : 'SystemAbortTransaction',
	#superclass : 'SystemTransactionNotification',
	#category : 'Grease-GemStone-Core',
	#package : 'Grease-GemStone-Core'
}

{ #category : 'accessing' }
SystemAbortTransaction >> alternatives [

	^'Please use SeasidePlatformSupport>>doRollbackUserObjects instead.'
]

{ #category : 'ANSI - signaledException' }
SystemAbortTransaction >> defaultAction [

	^System abortTransaction
]

{ #category : 'accessing' }
SystemAbortTransaction >> transaction [

	^'Abort'
]
