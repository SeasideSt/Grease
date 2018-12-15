private
supportedEncodingNames
	"answers the names of the encodings supported by this class"

	^ (TextConverter allSubclasses gather: [ :class | class encodingNames ]) asOrderedCollection
		removeAllFoundIn: GRPharoLatin1Codec supportedEncodingNames;
		removeAllFoundIn: UTF8TextConverter encodingNames;
		yourself