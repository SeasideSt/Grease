running
checkMethod: aMethod
	(aMethod methodClass isMeta not 
		and: [ (aMethod selector beginsWithSubCollection: #initialize) 
		and: [ aMethod numArgs > 0
		and: [ aMethod class ~= GRObject
		and: [ (aMethod methodClass includesBehavior: GRObject)
		and: [ (aMethod superMessages includes: aMethod selector) not 
		and: [ aMethod selfMessages noneSatisfy: [ :each | each beginsWithSubCollection: #initialize ] ] ] ] ] ] ]) 
			ifTrue: [ result addClass: aMethod methodClass selector: aMethod selector ]