Extension { #name : 'ExceptionA' }

{ #category : '*grease-gemstone240-core' }
ExceptionA >> greaseString [

	^self description

]

{ #category : '*grease-gemstone240-core' }
ExceptionA >> raiseSignal [

	^self signal
]

{ #category : '*grease-gemstone240-core' }
ExceptionA classSide >> raiseSignal: aString [
	^ self signal: aString
]

{ #category : '*grease-gemstone240-core' }
ExceptionA >> raiseSignal: aString [
	^ self signal: aString
]
