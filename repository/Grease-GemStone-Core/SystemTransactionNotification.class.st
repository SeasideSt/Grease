Class {
	#name : 'SystemTransactionNotification',
	#superclass : 'Notification',
	#category : 'Grease-GemStone-Core',
	#package : 'Grease-GemStone-Core'
}

{ #category : 'accessing' }
SystemTransactionNotification >> alternatives [

	self subclassResponsibility: #alternatives
]

{ #category : 'accessing' }
SystemTransactionNotification >> transaction [

	self subclassResponsibility: #transaction
]
