running
checkMethod: aMethod
	| foundLiteral |
	foundLiteral := false.
	"check individual literals first"
	aMethod literals do: [ :each | 
		(each isString and: [ each isWideString ]) ifTrue: [
			result 
				addClass: aMethod methodClass
				selector: aMethod selector.
			result addSearchString:  each.
			foundLiteral := true ] ].
	
	"now check the whole method, could be in comments"
	foundLiteral ifFalse: [
		aMethod sourceCode asString isWideString ifTrue: [
			result addClass: aMethod methodClass selector: aMethod selector ] ]