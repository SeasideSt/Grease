running
checkClass: aClass

	| comment |
	aClass isMeta ifTrue: [ ^ self ].
	comment := aClass comment asString.
	comment isWideString ifTrue: [ result addClass: aClass ]