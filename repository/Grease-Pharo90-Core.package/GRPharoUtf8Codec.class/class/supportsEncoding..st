private
supportsEncoding: aString
	^ GRPlatform current utf8CodecClass == self and: [ (#('utf-8' 'UTF-8' 'utf8') includes: aString) ]