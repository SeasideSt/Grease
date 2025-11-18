Extension { #name : 'Duration' }

{ #category : '*Grease-Pharo60-Core' }
Duration >> asMilliseconds [
	^ self asMilliSeconds
]

{ #category : '*Grease-Pharo60-Core' }
Duration >> milliseconds [
	^ nanos quo: NanosInMillisecond
]

{ #category : '*Grease-Pharo60-Core' }
Duration class >> milliseconds: anInteger [
	^ self milliSeconds: anInteger
]
