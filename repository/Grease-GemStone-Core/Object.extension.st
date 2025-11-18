Extension { #name : 'Object' }

{ #category : '*grease-gemstone-core' }
Object >> displayString [	
	self
		greaseDeprecatedApi: 'Object>>#displayString'
		details: 'Use #seasideString.'.
	^ self asString
]

{ #category : '*grease-gemstone-core' }
Object >> greaseString [
	^ self asString
]

{ #category : '*grease-gemstone-core' }
Object >> isMessageSend [

	^false.
]
