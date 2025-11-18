Class {
	#name : 'GRUsesNotPortableClassRule',
	#superclass : 'GRSlimeBlockLintRule',
	#category : 'Grease-Slime',
	#package : 'Grease-Slime'
}

{ #category : 'running' }
GRUsesNotPortableClassRule >> checkClass: aContext [ 
	aContext selectedClass allSuperclassesDo: [ :each |
		(self classNames includes: each name) ifTrue: [
			result addClass: aContext selectedClass.
			result addSearchString: each name ] ]
]

{ #category : 'running' }
GRUsesNotPortableClassRule >> checkMethod: aContext [ 
	(aContext selectedClass theNonMetaClass category indexOfSubCollection: #'-Pharo-' startingAt: 1) ~= 0 ifTrue: [
		"classes in a -Pharo- package are per definition not portable and therefore allowed to use non-portable classes"
		^ self ].
	aContext compiledMethod literals do: [ :each | 
		(each isVariableBinding and: [ self classNames includes: each key ]) ifTrue: [
			result 
				addClass: aContext selectedClass
				selector: aContext selector.
			result addSearchString: each key ] ]
]

{ #category : 'private' }
GRUsesNotPortableClassRule >> classNames [
	^ #( Delay MIMEDocument Monitor Mutex MutexSet Random Semaphore TimeStamp Timestamp MessageSend )
]

{ #category : 'accessing' }
GRUsesNotPortableClassRule >> group [
	^ 'Grease Portability'
]

{ #category : 'accessing' }
GRUsesNotPortableClassRule >> name [
	^ 'Uses not portable class'
]

{ #category : 'accessing' }
GRUsesNotPortableClassRule >> rationale [
	^ 'Some classes are not portable accross different Smalltalk dialects.'
]
