Extension { #name : 'GRUtf8CodecTest' }

{ #category : '*grease-tests-gemstone-core' }
GRUtf8CodecTest >> expectedFailures [
	^ #( 
		#testCodecUtf8Bom				"GemStone interprest bom character as a space ... nicht richtig"
		)
]
