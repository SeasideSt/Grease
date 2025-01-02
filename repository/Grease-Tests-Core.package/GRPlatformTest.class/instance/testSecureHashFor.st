tests
testSecureHashFor
	"Make sure the platform class provides a #secureHashFor: method. The method is called by Seaside when hashing passwords. 
	The Pharo implementation returns a SHA-1 hash but another equivalent hash method could also be used."
	
	| a b c d invalidUtf8 e f |
	a := self platform secureHashFor: 'foobar'.
	b := self platform secureHashFor: 'foobar'.
	self assert: a equals: b.

	c := self platform secureHashFor: #[102 111 111 98 97 114].
	d := self platform secureHashFor: #[102 111 111 98 97 114].
	self assert: c equals: d.
	
	"The following ensures any byte array can be used (and not only the onces containing valid utf8)"
	invalidUtf8 := #[160 161].
	e := self platform secureHashFor: invalidUtf8.
	f := self platform secureHashFor: invalidUtf8.
	self assert: e equals: f