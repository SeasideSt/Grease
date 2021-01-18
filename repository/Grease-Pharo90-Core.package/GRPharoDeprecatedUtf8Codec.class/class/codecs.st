accessing
codecs
	^ GRPlatform current utf8CodecClass == self
		ifTrue:[ Array with: self new ]
		ifFalse: [ Array new ]