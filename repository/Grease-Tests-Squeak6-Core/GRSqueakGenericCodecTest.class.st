Class {
	#name : 'GRSqueakGenericCodecTest',
	#superclass : 'TestCase',
	#category : 'Grease-Tests-Squeak6-Core',
	#package : 'Grease-Tests-Squeak6-Core'
}

{ #category : 'tests' }
GRSqueakGenericCodecTest >> testNoAmbiguities [
	#('utf-8' 'UTF-8' 'utf8') do: [ :each |
		self deny: (GRSqueakGenericCodec supportsEncoding: each) ].
	GRSqueakLatin1Codec supportedEncodingNames do: [ :each |
		self deny: (GRSqueakGenericCodec supportsEncoding: each) ]
]
