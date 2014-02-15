accessing
addAll: aDictionary
	aDictionary keysAndValuesDo: [ :key :value | self add: key -> value ].
	^ aDictionary