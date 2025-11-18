Class {
	#name : 'GRUsesClassForHashRule',
	#superclass : 'GRSlimeParseTreeLintRule',
	#category : 'Grease-Pharo40-Slime',
	#package : 'Grease-Pharo40-Slime'
}

{ #category : 'running' }
GRUsesClassForHashRule >> checkMethod: aContext [
	aContext parseTree selector = #hash
		ifTrue: [ super checkMethod: aContext ]
]

{ #category : 'accessing' }
GRUsesClassForHashRule >> group [
	^ 'Grease Portability'
]

{ #category : 'initialization' }
GRUsesClassForHashRule >> initialize [
	super initialize.
	self matcher
		matches: '`@receiver class hash'
		do: [ :node :answer | answer isNil ifTrue: [ node ] ifFalse: [ answer ] ]
]

{ #category : 'accessing' }
GRUsesClassForHashRule >> name [
	^ 'Uses its class for hash'
]

{ #category : 'accessing' }
GRUsesClassForHashRule >> rationale [
	^ 'The hash of an object should not depend on the hash of its class as some Smalltalk have non-constant class hashes.'
]
