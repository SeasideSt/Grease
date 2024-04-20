encoding
supportsUnicode
	"dynamically try to figure out whether the current dialect supports Unicode"

	^ [ 
		String
			with: (Character codePoint: 16r1F1F3)
			with: (Character codePoint: 16r1F1F1).
		true
	 ] on: Error
		do: [ :error | false ]