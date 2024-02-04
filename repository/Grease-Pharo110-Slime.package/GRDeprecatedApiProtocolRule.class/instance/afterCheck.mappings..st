hooks
afterCheck: aNode mappings: mappingDict
	
	| method |
	method := aNode methodNode.
	" This ensures that the description is of the form ClassName>>#selector:"
	(aNode arguments first isLiteralNode
		and: [ aNode arguments first value isString
			and: [ method methodClass name greaseString , '>>#' , method selector greaseString ~= aNode arguments first value ] ]) ifTrue: [ ^ true ].

	" This ensures that the description is a string and ends with a dot."
	^ (aNode arguments size > 1
			and: [ aNode arguments second isLiteralNode
			and: [ aNode arguments second value isString
			and: [ (aNode arguments second value endsWithSubCollection: '.') not ] ] ])