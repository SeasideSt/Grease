Class {
	#name : 'GRAnsiExceptionsRule',
	#superclass : 'GRSlimeTransformationRule',
	#category : 'Grease-Pharo40-Slime',
	#package : 'Grease-Pharo40-Slime'
}

{ #category : 'accessing' }
GRAnsiExceptionsRule >> group [
	^ 'ANSI Compatibility'
]

{ #category : 'initialization' }
GRAnsiExceptionsRule >> initialize [
	super initialize.
	self rewriteRule
		replace: '``@block on: `class do: [ | `@temps | ``@.body ]'
			with: '``@block on: `class do: [ :err | | `@temps | ``@.body ]'
]

{ #category : 'accessing' }
GRAnsiExceptionsRule >> name [
	^ 'Exceptions'
]

{ #category : 'accessing' }
GRAnsiExceptionsRule >> rationale [
	^ 'Exception handlers expect exactly one argument in ANSI.'
]
