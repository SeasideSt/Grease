accessing
utf8StringOrByteArrayForCodec: codec
	^ codec encodedStringClass == ByteArray
		ifTrue:[ self asByteArray: #(195 156 98 195 168 114 115 116 114 195 174 195 177 103 195 169) ]
		ifFalse:[ self asString: #(195 156 98 195 168 114 115 116 114 195 174 195 177 103 195 169) ]