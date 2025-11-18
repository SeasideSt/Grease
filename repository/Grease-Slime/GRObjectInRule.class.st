"
I detect senders of Object >> #in:

"
Class {
	#name : 'GRObjectInRule',
	#superclass : 'GRSlimeTransformationRule',
	#category : 'Grease-Slime',
	#package : 'Grease-Slime'
}

{ #category : 'accessing' }
GRObjectInRule >> group [
	^ 'Grease Portability'
]

{ #category : 'initialization' }
GRObjectInRule >> initialize [
	super initialize.
	self rewriteRule
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
