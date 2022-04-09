accessing
codecs
	^ self supportedEncodingNames
		collect: [ :each | self basicForEncoding: each greaseString ]