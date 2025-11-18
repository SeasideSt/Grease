Class {
	#name : 'GRDurationTest',
	#superclass : 'TestCase',
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'tests' }
GRDurationTest >> testAccessors [
	| duration |
	duration := Duration seconds: 356521.
	self assert: duration days = 4.
	self assert: duration hours = 3.
	self assert: duration minutes = 2.
	self assert: duration seconds = 1.
	self assert: duration milliseconds = 0
]

{ #category : 'tests' }
GRDurationTest >> testBasicInstanceCreation [
	self assert: (Duration days: 1 hours: 1 minutes: 1 seconds: 1) asMilliseconds = 90061000.
	self assert: (Duration weeks: 1) asMilliseconds = 604800000.
	self assert: (Duration days: 1) asMilliseconds = 86400000.
	self assert: (Duration hours: 1) asMilliseconds = 3600000.
	self assert: (Duration minutes: 1) asMilliseconds = 60000.
	self assert: (Duration seconds: 1) asMilliseconds = 1000.
	self assert: (Duration milliseconds: 1) asMilliseconds = 1
]

{ #category : 'tests' }
GRDurationTest >> testConversions [
	| duration |
	duration := Duration days: 4 hours: 3 minutes: 2 seconds: 1.
	self assert: duration asSeconds = 356521.
	self assert: duration asMilliseconds = 356521000.
	self assert: duration negated asSeconds = -356521.
	self assert: duration negated asMilliseconds = -356521000
]

{ #category : 'testing' }
GRDurationTest >> testIntegerConvenienceMethods [
	self assert: 5 weeks = (Duration weeks: 5).
	self assert: 5 days = (Duration days: 5).
	self assert: 5 hours = (Duration hours: 5).
	self assert: 5 minutes = (Duration minutes: 5).
	self assert: 5 seconds = (Duration seconds: 5).
	self assert: 5 milliseconds = (Duration milliseconds: 5)
]

{ #category : 'tests' }
GRDurationTest >> testMixedInstanceCreation [
	self assert: (Duration days: 1 hours: -23 minutes: 1 seconds: -59) asMilliseconds = 3601000
]

{ #category : 'tests' }
GRDurationTest >> testNegativeInstanceCreation [
	self assert: (Duration days: -1 hours: -1 minutes: -1 seconds: -1) asMilliseconds = -90061000.
	self assert: (Duration weeks: -1) asMilliseconds = -604800000.
	self assert: (Duration days: -1) asMilliseconds = -86400000.
	self assert: (Duration hours: -1) asMilliseconds = -3600000.
	self assert: (Duration minutes: -1) asMilliseconds = -60000.
	self assert: (Duration seconds: -1) asMilliseconds = -1000.
	self assert: (Duration milliseconds: -1) asMilliseconds = -1
]

{ #category : 'tests' }
GRDurationTest >> testPartialSecondsInstanceCreation [
	"ANSI 5.8.3.1 and 5.8.3.2 specify that the seconds argument can be any
	Number - not just an integer as is the case for the other arguments."
	self assert: (Duration days: 0 hours: 0 minutes: 0 seconds: 1.5) asMilliseconds = 1500.
	self assert: (Duration days: 0 hours: 0 minutes: 0 seconds: 3/2) asMilliseconds = 1500.
	self assert: (Duration seconds: 1.5) asMilliseconds = 1500.
	self assert: (Duration seconds: 3/2) asMilliseconds = 1500
]

{ #category : 'tests' }
GRDurationTest >> testRolloverInstanceCreation [
	self assert: (Duration days: 0 hours: 25 minutes: 61 seconds: 61) asMilliseconds = 93721000.
	self assert: (Duration hours: 25) asMilliseconds = 90000000.
	self assert: (Duration minutes: 61) asMilliseconds = 3660000.
	self assert: (Duration seconds: 61) asMilliseconds = 61000.
	self assert: (Duration milliseconds: 1001) asMilliseconds = 1001
]

{ #category : 'tests' }
GRDurationTest >> testZero [
	| duration |
	duration := Duration zero.
	self assert: duration isZero.
	self assert: duration asMilliseconds = 0.
	self assert: duration = (Duration seconds: 0)
]
