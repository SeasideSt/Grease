Class {
	#name : 'SystemBeginTransaction',
	#superclass : 'SystemTransactionNotification',
	#category : 'Grease-GemStone-Core',
	#package : 'Grease-GemStone-Core'
}

{ #category : 'accessing' }
SystemBeginTransaction >> alternatives [

	^'Please use SeasidePlatformSupport>>doRollbackUserObjects instead.'
]

{ #category : 'ANSI - signaledException' }
SystemBeginTransaction >> defaultAction [

	^System beginTransaction
]

{ #category : 'accessing' }
SystemBeginTransaction >> transaction [

	^'Begin'
]
