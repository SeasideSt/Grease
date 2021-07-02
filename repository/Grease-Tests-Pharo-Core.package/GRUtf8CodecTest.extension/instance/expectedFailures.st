*Grease-Tests-Pharo-Core
expectedFailures
	^ SystemVersion current major < 9 
		ifTrue: [ #(testCodecUtf8ShortestForm) ]
		ifFalse:[ #() ]