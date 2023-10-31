running
checkClass: aContext

	| comment |
	aContext isMeta ifTrue: [ ^ self ].
	comment := aContext classComment asString.
	comment isWideString ifTrue: [ result addClass: aContext ]