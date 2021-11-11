convenience
decode: aByteArray
	"^ super decode: aByteArray asByteArray"
	^ aByteArray asByteArray utf8Decoded