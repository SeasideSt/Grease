tests
testBase64Encode
	| input |
	input := #(
		(97 110 121 32 99 97 114 110 97 108 32 112 108 101 97 115 117 114 101 46) 'YW55IGNhcm5hbCBwbGVhc3VyZS4=' 
		(97 110 121 32 99 97 114 110 97 108 32 112 108 101 97 115 117 114 101) 'YW55IGNhcm5hbCBwbGVhc3VyZQ=='
		(97 110 121 32 99 97 114 110 97 108 32 112 108 101 97 115 117 114) 'YW55IGNhcm5hbCBwbGVhc3Vy'
		(97 110 121 32 99 97 114 110 97 108 32 112 108 101 97 115 117) 'YW55IGNhcm5hbCBwbGVhc3U=' 
		(97 110 121 32 99 97 114 110 97 108 32 112 108 101 97 115) 'YW55IGNhcm5hbCBwbGVhcw==').
	1 to: input size by: 2 do: [ :index |
		| decoded expected |
		decoded := GRPlatform current base64Encode: (input at: index) asByteArray.
		expected := input at: index + 1.
		self assert: decoded = expected ]