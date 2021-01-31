utf8 codec
utf8CodecClass

	^ utf8DeprecatedCodecFlag
		  ifNil: [ GRPharoDeprecatedUtf8Codec ]
		  ifNotNil: [ utf8DeprecatedCodecFlag
								ifTrue:[ GRPharoDeprecatedUtf8Codec ]
								ifFalse: [ GRPharoUtf8Codec ] ]