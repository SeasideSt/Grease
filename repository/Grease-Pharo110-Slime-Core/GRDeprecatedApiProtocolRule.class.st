Class {
	#name : 'GRDeprecatedApiProtocolRule',
	#superclass : 'GRReSlimeParseTreeLintRule',
	#category : 'Grease-Pharo110-Slime-Core',
	#package : 'Grease-Pharo110-Slime-Core'
}

{ #category : 'hooks' }
GRDeprecatedApiProtocolRule >> afterCheck: aNode mappings: mappingDict [
	
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
]

{ #category : 'accessing' }
GRDeprecatedApiProtocolRule >> group [

	^ 'Grease Formatting'
]

{ #category : 'initialization' }
GRDeprecatedApiProtocolRule >> initialize [

	super initialize.
	self
		matchesAny: #(
			'``@receiver greaseDeprecatedApi: ``@arg1'
			'``@receiver greaseDeprecatedApi: ``@arg1 details: ``@arg2' )
]

{ #category : 'accessing' }
GRDeprecatedApiProtocolRule >> name [

	^ 'Invalid use of deprecated API protocol.'
]

{ #category : 'accessing' }
GRDeprecatedApiProtocolRule >> rationale [

	^ 'Make sure to follow the following pattern: self greaseDeprecatedApi: ''Class>>#selector'' details: ''Some description''.'
]
