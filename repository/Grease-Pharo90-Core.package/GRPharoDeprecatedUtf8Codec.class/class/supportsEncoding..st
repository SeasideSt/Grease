testing
supportsEncoding: aString
	^ GRPlatform current utf8CodecClass == self and: [(#('utf-8' 'UTF-8') includes: aString) or: [ UTF8TextConverter encodingNames includes: aString ] ]