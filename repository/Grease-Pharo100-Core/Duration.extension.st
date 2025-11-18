Extension { #name : 'Duration' }

{ #category : '*Grease-Pharo100-Core' }
Duration >> asMilliseconds [
	^ self asMilliSeconds
]

{ #category : '*Grease-Pharo100-Core' }
Duration >> milliseconds [
	^ nanos quo: NanosInMillisecond
]

{ #category : '*Grease-Pharo100-Core' }
Duration class >> milliseconds: anInteger [
	^ self milliSeconds: anInteger
]
