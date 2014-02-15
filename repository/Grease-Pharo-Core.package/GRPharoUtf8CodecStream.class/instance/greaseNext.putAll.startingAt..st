streaming
greaseNext: anInteger putAll: aCollection startingAt: startIndex
	| index |
	aCollection isByteString
		ifTrue: [ 
			index := ByteString findFirstInString: aCollection inSet: Latin1ToUtf8Map startingAt: startIndex.
			(index = 0 or: [ index > (startIndex + anInteger - 1) ])
				ifTrue: [ stream greaseNext: anInteger putAll: aCollection startingAt: startIndex ]
				ifFalse: [ super greaseNext: anInteger putAll: aCollection startingAt: startIndex ] ]
		ifFalse: [ super greaseNext: anInteger putAll: aCollection startingAt: startIndex ]