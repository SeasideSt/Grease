Class {
	#name : 'GRNotPortableCollectionsRule',
	#superclass : 'GRReSlimeTransformationRule',
	#category : 'Grease-Pharo110-Slime-Portability',
	#package : 'Grease-Pharo110-Slime-Portability'
}

{ #category : 'accessing' }
GRNotPortableCollectionsRule >> group [

	^ 'Grease Portability'
]

{ #category : 'initialization' }
GRNotPortableCollectionsRule >> initialize [

	super initialize.
	self
		replace: '`@collection beginsWith: `@subCollection'
			with: '`@collection greaseBeginsWith: `@subCollection';
		replace: '`@collection endsWith: `@subCollection'
			with: '`@collection greaseEndsWith: `@subCollection'
]

{ #category : 'accessing' }
GRNotPortableCollectionsRule >> name [

	^ 'Collections'
]

{ #category : 'accessing' }
GRNotPortableCollectionsRule >> rationale [

	^ '#beginsWith: and #endsWith: are not portable.'
]
