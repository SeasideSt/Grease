Class {
	#name : 'GRNonPortableMessageRule',
	#superclass : 'GRReSlimeBlockLintRule',
	#category : 'Grease-Pharo110-Slime-Portability',
	#package : 'Grease-Pharo110-Slime-Portability'
}

{ #category : 'testing - interest' }
GRNonPortableMessageRule class >> checksNode [

	^ true
]

{ #category : 'running' }
GRNonPortableMessageRule >> basicCheck: anEntity [

	^ anEntity isMessage and:[ self methodNames includes: anEntity selector ]

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
