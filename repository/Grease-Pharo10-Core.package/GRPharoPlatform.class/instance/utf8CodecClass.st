utf8 codec
utf8CodecClass

	^ utf8DeprecatedCodecFlag
		  ifNil: [ GRPharoUtf8Codec ]
		  ifNotNil: [ utf8DeprecatedCodecFlag
								ifTrue:[ GRPharoDeprecatedUtf8Codec ]
								ifFalse: [ GRPharoUtf8Codec ] ]