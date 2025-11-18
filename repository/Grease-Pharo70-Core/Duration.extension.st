Extension { #name : 'Duration' }

{ #category : '*Grease-Pharo70-Core' }
Duration >> asMilliseconds [
	^ self asMilliSeconds
]

{ #category : '*Grease-Pharo70-Core' }
Duration >> milliseconds [
	^ nanos quo: NanosInMillisecond
]

{ #category : '*Grease-Pharo70-Core' }
Duration class >> milliseconds: anInteger [
	^ self milliSeconds: anInteger
]
