encoding
integerAsByteArray: anInteger
	| stream |
	stream := ByteArray new writeStream.
	anInteger greaseBytesCount to: 1 by: -1 do: [:digitIndex |
		stream nextPut: (anInteger greaseByteAt: digitIndex)].
	^ stream contents