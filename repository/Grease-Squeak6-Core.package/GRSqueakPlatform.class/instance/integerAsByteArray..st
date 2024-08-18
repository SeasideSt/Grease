encoding
integerAsByteArray: anInteger
	| size array |
	size := anInteger greaseBytesCount.
	array := ByteArray new: size.
	size to: 1 by: -1 do: [ :digitIndex |
		array
			at: size - digitIndex + 1
			put: (anInteger greaseByteAt: digitIndex) ].
	^ array