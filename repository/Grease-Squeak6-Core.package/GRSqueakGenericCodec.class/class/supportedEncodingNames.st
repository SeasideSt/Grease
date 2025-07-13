private
supportedEncodingNames
	"answers the names of the encodings supported by this class"

	^ (TextConverter allSubclasses gather: [ :class | class encodingNames ]) asSet asOrderedCollection
		removeAllFoundIn: GRSqueakLatin1Codec supportedEncodingNames;
		removeAllFoundIn: UTF8TextConverter encodingNames;
		yourself