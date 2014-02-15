tests
testSignalErrorClassSide
	"Exception class>>signal is part of the ANSI Smalltalk standard. However, Seaside
	only signals subclasses of WAPlatformError and WAPlatformNotification so Smalltalk
	implementations that do not otherwise provide it can implement it on
	these two classes."
	[ GRError signal ] 
		on: GRError
		do: [ :e | ^ self ].
	self assert: false