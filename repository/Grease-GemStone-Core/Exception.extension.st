Extension { #name : 'Exception' }

{ #category : '*grease-gemstone-core' }
Exception class >> raiseSignal [
	^ self signal
]

{ #category : '*grease-gemstone-core' }
Exception >> raiseSignal [
	^ self signal
]

{ #category : '*grease-gemstone-core' }
Exception class >> raiseSignal: aString [
	^ self signal: aString
]

{ #category : '*grease-gemstone-core' }
Exception >> raiseSignal: aString [
	^ self signal: aString
]
