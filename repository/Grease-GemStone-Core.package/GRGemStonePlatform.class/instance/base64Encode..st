encoding
base64Encode: aByteArray
	^ (Base64MimeConverter mimeEncode: aByteArray readStream) contents
