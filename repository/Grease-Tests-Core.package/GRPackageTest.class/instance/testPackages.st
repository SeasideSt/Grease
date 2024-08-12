tests-packages
testPackages
	| packages |
	true 
		ifTrue: [
			"GRPackage appears to no longer be supported" 
			"https://github.com/GsDevKit/Grease/issues/32"
			^self ]. 
	packages := GRPackage grPackages.
	self assert: packages notEmpty.
	packages do: [ :each | 
		self assert: each name notEmpty.
		self assert: each license notNil.
		self deny: (each dependencies includes: nil).
		self assert: each url notNil ].
