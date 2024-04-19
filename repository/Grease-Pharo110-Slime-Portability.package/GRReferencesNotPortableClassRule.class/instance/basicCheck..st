running
basicCheck: aMethod

	(aMethod methodClass instanceSide category indexOfSubCollection: #'-Pharo-' startingAt: 1) ~= 0 ifTrue: [ 
		"classes in a -Pharo- package are per definition not portable and therefore allowed to use non-portable classes" 
		^ false ].

	^ aMethod literals anySatisfy: [ :each | each isVariableBinding and: [ self classNames includes: each key ] ]