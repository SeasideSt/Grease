utilities
printDigitsOf: aNumber withLength: aLengthInteger on: aStream
	"Print the digits of aNumber with a lenght of aLengthInteger on aStream.
	Also print a separator if required."

	| rest |
	rest := aNumber truncated abs.
	1 to: aLengthInteger do: [ :index |
		| divisor current |
		divisor := base raisedTo: aLengthInteger - index.
		current := rest // divisor.
		separator isNil ifFalse: [ 
			 (index ~= 1 and: [ (aLengthInteger - index) \\ 3 = 2 ])
				ifTrue: [ aStream nextPut: separator ] ].
		aStream nextPut: (characters at: current + 1).
		rest := rest - (divisor * current) ]