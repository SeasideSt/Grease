Class {
	#name : 'GRUsesNotPortableClassRule',
	#superclass : 'GRReSlimeBlockLintRule',
	#category : 'Grease-Pharo110-Slime-Portability',
	#package : 'Grease-Pharo110-Slime-Portability'
}

{ #category : 'testing' }
GRUsesNotPortableClassRule class >> isAbstract [ 

	^ self name = #GRUsesNotPortableClassRule
]

{ #category : 'testing' }
GRUsesNotPortableClassRule class >> isVisible [

	^ self name ~= #GRUsesNotPortableClassRule
]

{ #category : 'private' }
GRUsesNotPortableClassRule >> classNames [

	^ #( Delay MIMEDocument Monitor Mutex MutexSet Random Semaphore TimeStamp Timestamp MessageSend )
]

{ #category : 'accessing' }
GRUsesNotPortableClassRule >> group [

	^ 'Grease Portability'
]

{ #category : 'accessing' }
GRUsesNotPortableClassRule >> rationale [

	^ 'Some classes are not portable accross different Smalltalk dialects.'
]
