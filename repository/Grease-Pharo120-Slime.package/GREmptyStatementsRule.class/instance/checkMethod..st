running
checkMethod: aMethod 
	| periods position |
	aMethod ast nodesDo: [ :node |
		(node isSequence and: [ node periods notEmpty ]) ifTrue: [
			periods := OrderedCollection withAll: node periods.
			1 to: node statements size - 1 do: [ :index |
				position := periods removeFirst.
				((node statements at: index) stop < position and: [ position < (node statements at: index + 1) start ])
					ifFalse: [ ^ result addClass: aMethod methodClass selector: aMethod selector ] ].
			(periods isEmpty or: [ periods size = 1 and: [ node statements notEmpty and: [ node statements last stop < periods first ] ] ])
				ifFalse: [ ^ result addClass: aMethod methodClass selector: aMethod selector ] ] ]