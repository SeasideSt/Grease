running
checkMethod: aMethod 
	aMethod ast nodesDo: [ :node |
		node isSequence ifTrue: [
			(node statements notEmpty and: [ node periods notEmpty ]) ifTrue: [
				node periods last > node statements last stop ifTrue: [
					^ result addClass: aMethod methodClass selector: aMethod selector ] ] ] ]