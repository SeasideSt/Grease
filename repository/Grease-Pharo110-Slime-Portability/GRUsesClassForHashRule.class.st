Class {
	#name : 'GRUsesClassForHashRule',
	#superclass : 'GRReSlimeParseTreeLintRule',
	#category : 'Grease-Pharo110-Slime-Portability',
	#package : 'Grease-Pharo110-Slime-Portability'
}

{ #category : 'hooks' }
GRUsesClassForHashRule >> afterCheck: aNode mappings: mappingDict [
	
	^ aNode methodNode selector = #hash
]

{ #category : 'accessing' }
GRUsesClassForHashRule >> group [

	^ 'Grease Portability'
]

{ #category : 'initialization' }
GRUsesClassForHashRule >> initialize [

	super initialize.
	self matches: '`@receiver class hash'
]

{ #category : 'accessing' }
GRUsesClassForHashRule >> name [

	^ 'Uses its class for hash'
]

{ #category : 'accessing' }
GRUsesClassForHashRule >> rationale [

	^ 'The hash of an object should not depend on the hash of its class as some Smalltalk have non-constant class hashes.'
]
