running
shouldExclude: aMethod
	"The REST and OmniBrowser related packages are OK to have pragmas"

	| classCategory |
	classCategory := aMethod methodClass instanceSide category.
	^ #( #'-REST-' 'OmniBrowser' ) anySatisfy: [ :each |
		  (classCategory indexOfSubCollection: each startingAt: 1) ~= 0 ]