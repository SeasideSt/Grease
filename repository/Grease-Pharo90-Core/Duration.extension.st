Extension { #name : 'Duration' }

{ #category : '*Grease-Pharo90-Core' }
Duration >> asMilliseconds [
	^ self asMilliSeconds
]

{ #category : '*Grease-Pharo90-Core' }
Duration >> milliseconds [
	^ nanos quo: NanosInMillisecond
]

{ #category : '*Grease-Pharo90-Core' }
Duration class >> milliseconds: anInteger [
	^ self milliSeconds: anInteger
]
