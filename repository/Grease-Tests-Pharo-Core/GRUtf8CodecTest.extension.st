Extension { #name : 'GRUtf8CodecTest' }

{ #category : '*Grease-Tests-Pharo-Core' }
GRUtf8CodecTest >> expectedFailures [
	^ SystemVersion current major < 9 
		ifTrue: [ #(testCodecUtf8ShortestForm) ]
		ifFalse:[ #() ]
]
