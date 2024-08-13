tests-packages
testPackages
	| packages |
	packages := GRPackage grPackages.
	self assert: packages notEmpty.
	packages do: [ :each | 
		self assert: each name notEmpty.
		self assert: each license notNil.
		self deny: (each dependencies includes: nil).
		self assert: each url notNil ].