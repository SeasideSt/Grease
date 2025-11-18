Extension { #name : 'Duration' }

{ #category : '*grease-squeak6-core' }
Duration >> asMilliseconds [
	^ self asMilliSeconds
]

{ #category : '*grease-squeak6-core' }
Duration >> milliseconds [
	^ nanos quo: NanosInMillisecond
]

{ #category : '*grease-squeak6-core' }
Duration class >> milliseconds: anInteger [
	^ self milliSeconds: anInteger
]
