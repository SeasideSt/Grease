Class {
	#name : 'GRSubclassesNotPortableClassRule',
	#superclass : 'GRUsesNotPortableClassRule',
	#category : 'Grease-Pharo110-Slime-Portability',
	#package : 'Grease-Pharo110-Slime-Portability'
}

{ #category : 'testing - interest' }
GRSubclassesNotPortableClassRule class >> checksClass [

	^ true
]

{ #category : 'running' }
GRSubclassesNotPortableClassRule >> basicCheck: aClass [

	^ aClass allSuperclasses anySatisfy: [ :each | self classNames includes: each name ]
]

{ #category : 'accessing' }
GRSubclassesNotPortableClassRule >> name [

	^ 'Subclasses not portable class'
]
