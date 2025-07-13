conversion
encoderFor: aWriteStream 
	"wrap to avoid String vs ByteArray issues"
	^ GRSqueakLatin1CodecStream on: aWriteStream