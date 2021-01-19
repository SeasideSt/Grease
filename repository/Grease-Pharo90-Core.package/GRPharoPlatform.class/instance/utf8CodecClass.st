utf8 codec
utf8CodecClass

	^ utf8DeprecatedCodecFlag
		  ifNil: [ GRPharoUtf8Codec ]
		  ifNotNil: [ GRPharoDeprecatedUtf8Codec ]