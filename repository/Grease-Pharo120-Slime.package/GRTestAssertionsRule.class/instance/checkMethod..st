running
checkMethod: aMethod 
	aMethod methodClass isMeta
		ifTrue: [ ^ self ].
	(aMethod methodClass inheritsFrom: #TestCase)
		ifFalse: [ ^ self ].
	^ super checkMethod: aMethod 