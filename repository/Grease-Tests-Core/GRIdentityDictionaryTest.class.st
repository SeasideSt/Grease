Class {
	#name : 'GRIdentityDictionaryTest',
	#superclass : 'GRAbstractDictionaryTest',
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'configuration' }
GRIdentityDictionaryTest >> collectionClass [
	^ IdentityDictionary
]

{ #category : 'configuration' }
GRIdentityDictionaryTest >> createArbitraryAssociations [
	^ OrderedCollection new
		add: 'c' -> 3;
		add: 'a' -> 1;
		add: 'b' -> 2;
		add: 'd' -> 1;
		add: 'b' copy -> 4;
		yourself
]

{ #category : 'configuration' }
GRIdentityDictionaryTest >> isKey: anObject equivalentTo: anotherObject [
	^ anObject == anotherObject
]
