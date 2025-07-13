tests
testNoAmbiguities
	#('utf-8' 'UTF-8' 'utf8') do: [ :each |
		self deny: (GRSqueakGenericCodec supportsEncoding: each) ].
	GRSqueakLatin1Codec supportedEncodingNames do: [ :each |
		self deny: (GRSqueakGenericCodec supportsEncoding: each) ]