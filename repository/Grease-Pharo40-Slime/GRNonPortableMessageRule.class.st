Class {
	#name : 'GRNonPortableMessageRule',
	#superclass : 'GRSlimeBlockLintRule',
	#category : 'Grease-Pharo40-Slime',
	#package : 'Grease-Pharo40-Slime'
}

{ #category : 'running' }
GRNonPortableMessageRule >> checkClass: aContext [
	| selectors |
	selectors := self methodNames
		inject: Set new
		into: [ :set :each | 
			set
				addAll: (aContext whichSelectorsReferTo: each);
				yourself ].
	selectors do: [ :each | result addClass: aContext selector: each ].
	selectors isEmpty
		ifFalse: [ result searchStrings: self methodNames ]
]

{ #category : 'accessing' }
GRNonPortableMessageRule >> group [
	^ 'Grease Portability'
]

{ #category : 'private' }
GRNonPortableMessageRule >> methodNames [
	^ #( anyOne withIndexCollect: )
]

{ #category : 'accessing' }
GRNonPortableMessageRule >> name [
	^ 'Uses non portable message'
]

{ #category : 'accessing' }
GRNonPortableMessageRule >> rationale [
	^ 'Some methods are not portable accross different Smalltalk dialects.'
]
