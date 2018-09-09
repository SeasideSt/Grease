utilities
lengthOf: aNumber base: aBaseInteger
	"Answer the number of digits of aNumber in the base aBaseInteger.
	Same as #decimalDigitLength"

	| integer current length |
	integer := aNumber truncated abs.
	length := 1.
	current := aBaseInteger.
	[ current <= integer ] whileTrue: [ 
		length := length + 1.
		current := current * aBaseInteger ].
	^ length