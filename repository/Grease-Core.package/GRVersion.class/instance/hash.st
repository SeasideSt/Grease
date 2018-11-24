comparing
hash
	^ (major hash
		bitXor: (minor ifNil: [ 0 ]) hash)
		bitXor: (revision ifNil: [ 0 ]) hash