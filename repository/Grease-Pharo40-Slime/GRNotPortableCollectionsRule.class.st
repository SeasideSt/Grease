Class {
	#name : 'GRNotPortableCollectionsRule',
	#superclass : 'GRSlimeTransformationRule',
	#category : 'Grease-Pharo40-Slime',
	#package : 'Grease-Pharo40-Slime'
}

{ #category : 'accessing' }
GRNotPortableCollectionsRule >> group [
	^ 'Grease Portability'
]

{ #category : 'initialization' }
GRNotPortableCollectionsRule >> initialize [
	super initialize.
	self rewriteRule
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
