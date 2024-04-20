running
basicCheck: aMethod

	^ (aMethod methodClass isMeta not
		and: [ (aMethod selector beginsWithSubCollection: #initialize)
		and: [ aMethod selector numArgs > 0
		and: [ aMethod methodClass ~= GRObject
		and: [ (aMethod methodClass includesBehavior: GRObject)
		and: [ (aMethod superMessages includes: aMethod selector) not
		and: [ aMethod selfMessages noneSatisfy: [ :each | each beginsWithSubCollection: #initialize ] ] ] ] ] ] ])