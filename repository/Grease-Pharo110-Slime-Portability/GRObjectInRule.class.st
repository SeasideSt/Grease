"
I detect senders of Object >> #in:

"
Class {
	#name : 'GRObjectInRule',
	#superclass : 'GRReSlimeTransformationRule',
	#category : 'Grease-Pharo110-Slime-Portability',
	#package : 'Grease-Pharo110-Slime-Portability'
}

{ #category : 'accessing' }
GRObjectInRule >> group [

	^ 'Grease Portability'
]

{ #category : 'initialization' }
GRObjectInRule >> initialize [

	super initialize.
	self
		replace: '``@object in: [ :`var | | `@temps | `@.statements ]'
		with: '[ :`var | | `@temps | `@.statements ] value: ``@object'
]

{ #category : 'accessing' }
GRObjectInRule >> name [

	^ 'Object>>#in:'
]

{ #category : 'accessing' }
GRObjectInRule >> rationale [

	^ 'Object>>#in: has different semantics on different Smalltalk dialects.'
]
