Extension { #name : 'Duration' }

{ #category : '*grease-gemstone-core' }
Duration >> asMilliseconds [

	^ self asMilliSeconds
]

{ #category : '*grease-gemstone-core' }
Duration >> milliseconds [

	^seconds abs \\ 1 * 1000 * seconds sign.
]

{ #category : '*grease-gemstone-core' }
Duration class >> milliseconds: millis [
	
	^self milliSeconds: millis
]
