file library
contentsOfFile: aString binary: aBoolean
	^ aBoolean
		ifTrue: [
			FileStream oldFileNamed: aString do: [ :stream |
				stream
					binary;
					contents ] ]
		ifFalse: [
			MultiByteFileStream oldFileNamed: aString do: [ :stream |
				stream
					ascii;
					wantsLineEndConversion: true;
					contents ] ]