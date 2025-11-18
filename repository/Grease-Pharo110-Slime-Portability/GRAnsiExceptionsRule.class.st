Class {
	#name : 'GRAnsiExceptionsRule',
	#superclass : 'GRReSlimeTransformationRule',
	#category : 'Grease-Pharo110-Slime-Portability',
	#package : 'Grease-Pharo110-Slime-Portability'
}

{ #category : 'accessing' }
GRAnsiExceptionsRule >> group [

	^ 'ANSI Compatibility'
]

{ #category : 'initialization' }
GRAnsiExceptionsRule >> initialize [

	super initialize.
	self
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
