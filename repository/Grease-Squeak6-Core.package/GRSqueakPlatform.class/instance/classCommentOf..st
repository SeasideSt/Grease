swagger
classCommentOf: aClass
	| comment |
	comment := aClass comment.
	^ (comment beginsWith: 'A ', aClass name asString, ' is xxxxxxxxx.')
		ifFalse: [ comment ]
		ifTrue: [ nil ]