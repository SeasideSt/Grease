Class {
	#name : 'GRPharoGenericCodecTest',
	#superclass : 'TestCase',
	#category : 'Grease-Tests-Pharo-Core',
	#package : 'Grease-Tests-Pharo-Core'
}

{ #category : 'tests' }
GRPharoGenericCodecTest >> testNoAmbiguities [
	(Smalltalk includesKey: #GRPharoGenericCodec) ifTrue:[
		#('utf-8' 'UTF-8' 'utf8') do: [ :each |
			self deny: ((Smalltalk at: #GRPharoGenericCodec) supportsEncoding: each) ].
		GRPharoLatin1Codec supportedEncodingNames do: [ :each |
			self deny: ((Smalltalk at: #GRPharoGenericCodec) supportsEncoding: each) ] ]
]
