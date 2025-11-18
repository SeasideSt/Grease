Class {
	#name : 'GRDictionaryTest',
	#superclass : 'GRAbstractDictionaryTest',
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'configuration' }
GRDictionaryTest >> collectionClass [
	^ Dictionary
]

{ #category : 'configuration' }
GRDictionaryTest >> createArbitraryAssociations [
	^ OrderedCollection new
		add: #c -> 3;
		add: #a -> 1;
		add: #b -> 2;
		add: #e -> 1;
		add: #d -> 4;
		yourself
]

{ #category : 'configuration' }
GRDictionaryTest >> isKey: anObject equivalentTo: anotherObject [
	^ anObject = anotherObject
]
