encoding
base64Encode: aByteArray
	^ (Base64MimeConverter base64Encode: aByteArray readStream) contents
