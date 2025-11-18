Class {
	#name : 'GRVersionTest',
	#superclass : 'TestCase',
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'asserting' }
GRVersionTest >> assert: aVersionArray equals: bVersionArray [
	| a b |
	a := self buildVersion: aVersionArray.
	b := self buildVersion: bVersionArray.
	self deny: a < b.
	self assert: a <= b.
	self deny: b < a.
	self assert: b <= a.
	self deny: b > a.
	self assert: b >= a.
	self deny: a > b.
	self assert: a >= b.
	self assert: a = b.
	self assert: a hash = b hash
]

{ #category : 'asserting' }
GRVersionTest >> assert: aVersionArray sortsBefore: bVersionArray [
	| a b |
	a := self buildVersion: aVersionArray.
	b := self buildVersion: bVersionArray.
	self assert: a < b.
	self assert: a <= b.
	self deny: b < a.
	self deny: b <= a.
	self assert: b > a.
	self assert: b >= a.
	self deny: a > b.
	self deny: a >= b.
	self deny: a = b
]

{ #category : 'private' }
GRVersionTest >> buildVersion: anArray [
	^ (GRVersion
		major: (anArray at: 1 ifAbsent: [ nil ])
		minor: (anArray at: 2 ifAbsent: [ nil ])
		revision: (anArray at: 3 ifAbsent: [ nil ]))
			stage: (anArray at: 4 ifAbsent: [ nil ]) number: (anArray at: 5 ifAbsent: [ nil ]);
			yourself
]

{ #category : 'tests' }
GRVersionTest >> testAccessors [
	| version |
	version := self buildVersion: #(1 2 3 #alpha 4).
	self assert: version major = 1.
	self assert: version minor = 2.
	self assert: version revision = 3.
	self assert: version stage = #alpha.
	self assert: version stageNumber = 4.
]

{ #category : 'tests' }
GRVersionTest >> testComparison [
	self assert: #(1) sortsBefore: #(2).
	self assert: #(2) sortsBefore: #(10).
	self assert: #(1) sortsBefore: #(1 1).
	self assert: #(1 nil nil #alpha) sortsBefore: #(1).
	self assert: #(1 nil nil #alpha) sortsBefore: #(1 0).
	self assert: #(1 nil nil #alpha) sortsBefore: #(1 0 0).
	self assert: #(1 0) sortsBefore: #(2).
	self assert: #(1 0) sortsBefore: #(2 0).
	self assert: #(1 0) sortsBefore: #(1 1).
	self assert: #(1 2) sortsBefore: #(1 10).
	self assert: #(1 0 nil #alpha) sortsBefore: #(1 0).
	self assert: #(1 0 nil #alpha) sortsBefore: #(1 0 0).
	self assert: #(1 0 0) sortsBefore: #(2).
	self assert: #(1 0 0) sortsBefore: #(1 1).
	self assert: #(1 0 1) sortsBefore: #(1 1).
	self assert: #(1 0 1 #alpha) sortsBefore: #(1 1).
	self assert: #(1 1 0 #alpha) sortsBefore: #(1 1).
	self assert: #(1 1 0 #alpha 2) sortsBefore: #(1 1).
	self assert: #(1 1 0 #beta) sortsBefore: #(1 1).
	self assert: #(1 1 0 #beta 2) sortsBefore: #(1 1).
	self assert: #(1 nil nil #alpha) sortsBefore: #(1 nil nil #alpha 2).
	self assert: #(1 nil nil #beta) sortsBefore: #(1 nil nil #beta 2).
	self assert: #(1 0 nil #alpha) sortsBefore: #(1 0 nil #alpha 2).
	self assert: #(1 0 nil #beta) sortsBefore: #(1 0 nil #beta 2).
	self assert: #(1 0 0 #alpha) sortsBefore: #(1 0 0 #alpha 2).
	self assert: #(1 0 0 #beta) sortsBefore: #(1 0 0 #beta 2)
]

{ #category : 'tests' }
GRVersionTest >> testConvenience [
	| version |
	version := GRVersion major: 1 minor: 2 revision: 3.
	self assert: version stage isNil.
	self assert: version stageNumber isNil.
	self assert: version isFinal.
	self deny: version isAlpha.
	self deny: version isBeta.
	version beAlpha.
	self assert: version stage = #alpha.
	self assert: version stageNumber isNil.
	self assert: version isAlpha.
	self deny: version isBeta.
	self deny: version isFinal.
	version beBeta.
	self assert: version stage = #beta.
	self assert: version stageNumber isNil.
	self assert: version isBeta.
	self deny: version isAlpha.
	self deny: version isFinal.
	version beReleaseCandidate.
	self assert: version stage = #rc.
	self assert: version stageNumber isNil.
	self assert: version isReleaseCandidate.
	version beReleaseCandidate: 1.
	self assert: version stage = #rc.
	self assert: version stageNumber = 1.
	self assert: version isReleaseCandidate.
	version beAlpha: 1.
	self assert: version stage = #alpha.
	self assert: version stageNumber = 1.
	self assert: version isAlpha.
	self deny: version isBeta.
	self deny: version isFinal.
	version beBeta: 1.
	self assert: version stage = #beta.
	self assert: version stageNumber = 1.
	self assert: version isBeta.
	self deny: version isAlpha.
	self deny: version isFinal.
	version beFinal.
	self assert: version stage isNil.
	self assert: version stageNumber isNil.
	self assert: version isFinal.
	self deny: version isAlpha.
	self deny: version isBeta
]

{ #category : 'tests' }
GRVersionTest >> testEquality [
	self assert: #(1) equals: #(1).
	self assert: #(1) equals: #(1 0).
	self assert: #(1) equals: #(1 0 0).
	self assert: #(1 0) equals: #(1 0).
	self assert: #(1 0) equals: #(1 0 0).
	self assert: #(1 0 0) equals: #(1 0 0).
	self assert: #(1 0 0 #alpha) equals: #(1 0 0 #alpha 1).
	self assert: #(1 0 0 #beta) equals: #(1 0 0 #beta 1)
]

{ #category : 'tests' }
GRVersionTest >> testStringConversion [
	self assert: (GRVersion major: 1 minor: 2 revision: 3) greaseString = '1.2.3'.
	self assert: (GRVersion major: 11 minor: 12 revision: 13) greaseString = '11.12.13'.
	self assert: (GRVersion major: 1 minor: 2) greaseString = '1.2'.
	self assert: (GRVersion major: 1 minor: 2 revision: 0) greaseString = '1.2.0'.
	self assert: (GRVersion major: 1) greaseString = '1.0'.
	self assert: ((GRVersion major: 1 minor: 2 revision: 3) beAlpha) greaseString = '1.2.3alpha'.
	self assert: ((GRVersion major: 1 minor: 2 revision: 3) beAlpha: 1) greaseString = '1.2.3alpha1'.
	self assert: ((GRVersion major: 1 minor: 2 revision: 3) beBeta) greaseString = '1.2.3beta'.
	self assert: ((GRVersion major: 1 minor: 2 revision: 3) beBeta: 1) greaseString = '1.2.3beta1'
]
