conversion
decoderFor: aReadStream 
	"wrap to avoid String vs ByteArray issues"
	^ GRSqueakLatin1CodecStream on: aReadStream