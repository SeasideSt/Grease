running
checkMethod: aMethod 
	aMethod methodClass isMeta
		ifTrue: [ ^ self ].
	(aMethod methodClass inheritsFrom: (Smalltalk classNamed: #TestCase))
		ifFalse: [ ^ self ].
	^ super checkMethod: aMethod 