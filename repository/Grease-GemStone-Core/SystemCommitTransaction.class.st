Class {
	#name : 'SystemCommitTransaction',
	#superclass : 'SystemTransactionNotification',
	#category : 'Grease-GemStone-Core',
	#package : 'Grease-GemStone-Core'
}

{ #category : 'accessing' }
SystemCommitTransaction >> alternatives [

	^'A commit is unnecessary. The framework will commit for you, before sending off the response.'
]

{ #category : 'ANSI - signaledException' }
SystemCommitTransaction >> defaultAction [

	^System _commitPrintingDiagnostics
]

{ #category : 'accessing' }
SystemCommitTransaction >> transaction [

	^'Commit'
]
