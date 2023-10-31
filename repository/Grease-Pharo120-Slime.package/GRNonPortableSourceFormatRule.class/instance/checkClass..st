running
checkClass: aClass

	| comment |
	aClass isMeta ifTrue: [ ^ self ].
	comment := aClass classComment asString.
	comment isWideString ifTrue: [ result addClass: aClass ]