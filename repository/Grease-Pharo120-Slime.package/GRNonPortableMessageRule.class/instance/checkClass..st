running
checkClass: aClass
	| selectors |
	selectors := self methodNames
		inject: Set new
		into: [ :set :each | 
			set
				addAll: (aClass whichSelectorsReferTo: each);
				yourself ].
	selectors do: [ :each | result addClass: aClass selector: each ].
	selectors isEmpty
		ifFalse: [ result searchStrings: self methodNames ]