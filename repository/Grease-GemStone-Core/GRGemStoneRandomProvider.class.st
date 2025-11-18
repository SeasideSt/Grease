Class {
	#name : 'GRGemStoneRandomProvider',
	#superclass : 'GRObject',
	#category : 'Grease-GemStone-Core',
	#package : 'Grease-GemStone-Core'
}

{ #category : 'accessing' }
GRGemStoneRandomProvider class >> generator [

	^SessionTemps current 
		at: #GRGemStoneRandomProvider_GENERATOR 
		ifAbsent: [
			SessionTemps current 
				at: #GRGemStoneRandomProvider_GENERATOR
				put: self randomClass new ]
]

{ #category : 'class initialization' }
GRGemStoneRandomProvider class >> initialize [
	"self initialize"
	
	SystemLoginNotification subscribe: self name.
]

{ #category : 'accessing' }
GRGemStoneRandomProvider class >> mutex [

	^SessionTemps current 
		at: #GRGemStoneRandomProvider_MUTEX 
		ifAbsent: [
			SessionTemps current 
				at: #GRGemStoneRandomProvider_MUTEX
				put: TransientSemaphore forMutualExclusion ]
]

{ #category : 'public' }
GRGemStoneRandomProvider class >> nextInt: anInteger [
	"Answer a random integer in the interval [1, anInteger]"
	^self mutex critical: [
		self generator nextInt: anInteger ]
]

{ #category : 'private' }
GRGemStoneRandomProvider class >> randomClass [
	"Answers the random number generator to be used to create session and continuation keys. 
	It will not be seeded, just #new will be sent. So wrap it if you need seeding.
	
	Used by Gemstone/S traditional Randoms which cannot be persisted.
	Used by GemStone to use a secure random when avaiable."
	
	^Smalltalk
		at: #TransientRandom
		ifAbsent: [ 
			Smalltalk 
				at: #HostRandom
				ifAbsent: [ Random ]]
]

{ #category : 'public' }
GRGemStoneRandomProvider class >> randomFrom: aCollection [
	|random count|
	random := self nextInt: aCollection size.
	^ aCollection isSequenceable
		ifTrue: [ aCollection at: random ]
		ifFalse: [
			count := 1.
			aCollection do: [ :ea |
				count = random ifTrue: [ ^ ea ].
				count := count + 1 ] ]
]

{ #category : 'class initialization' }
GRGemStoneRandomProvider class >> sessionStart [

	self generator open
]
