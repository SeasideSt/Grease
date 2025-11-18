Extension { #name : 'Collection' }

{ #category : '*grease-gemstone-core' }
Collection >> any [

	^self anyOne
]

{ #category : '*grease-gemstone-core' }
Collection >> sorted [

	^ self sorted: [ :a :b | a <= b ]
]

{ #category : '*grease-gemstone-core' }
Collection >> sorted: sortBlock [

	^ self sortBy: sortBlock
]
