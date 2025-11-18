Class {
	#name : 'GRUsesCurlyBraceArraysRule',
	#superclass : 'GRSlimeParseTreeLintRule',
	#category : 'Grease-Slime',
	#package : 'Grease-Slime'
}

{ #category : 'accessing' }
GRUsesCurlyBraceArraysRule >> group [
	^ 'Grease Portability'
]

{ #category : 'initialization' }
GRUsesCurlyBraceArraysRule >> initialize [
	super initialize.
	self matcher
		matches: '{ `@.stmts }'
		do: [ :node :answer | answer isNil ifTrue: [ node ] ifFalse: [ answer ] ]
]

{ #category : 'accessing' }
GRUsesCurlyBraceArraysRule >> name [
	^ 'Uses curly brace arrays'
]

{ #category : 'accessing' }
GRUsesCurlyBraceArraysRule >> rationale [
	^ 'Curly brace expressions are not portable accross different Smalltalk dialects.'
]
