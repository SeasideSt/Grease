Class {
	#name : 'GRPackageTest',
	#superclass : 'TestCase',
	#instVars : [
		'package'
	],
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'running' }
GRPackageTest >> setUp [
	super setUp.
	package := GRPackage new
]

{ #category : 'tests-dependencies' }
GRPackageTest >> testAllDependencies [
	| packages |
	packages := Dictionary new.
	packages 
		at: 'Lust' put: (GRPackage new
			name: 'Lust';
			addDependency: 'Gluttony';
			addDependency: 'Greed';
			yourself);
		at: 'Gluttony' put: (GRPackage new
			name: 'Gluttony';
			addDependency: 'Greed';
			yourself);
		at: 'Greed' put: (GRPackage new
			name: 'Greed';
			yourself).
	packages values 
		do: [ :each | each resolveWith: packages ].
	
	self assert: (packages at: 'Lust') allDependencies size = 3.
	self assert: (packages at: 'Gluttony') allDependencies size = 2.
	self assert: (packages at: 'Greed') allDependencies size = 1
]

{ #category : 'tests-dependencies' }
GRPackageTest >> testDependencies [
	self assert: package dependencies isEmpty.
	package addDependency: 'Lust'.
	package addDependency: 'Envy'.
	self assert: package dependencies size = 2.
	self assert: package dependencies first = 'Lust'.
	self assert: package dependencies last = 'Envy'
]

{ #category : 'tests' }
GRPackageTest >> testDescription [
	self assert: package description isNil.
	package description: 'A hopeless package'.
	self assert: package description = 'A hopeless package'
]

{ #category : 'tests' }
GRPackageTest >> testLicense [
	self assert: package license = #MIT.
	self assert: package isMIT.
	
	package license: #LGPL.
	self assert: package license = #LGPL.
	self assert: package isLGPL
]

{ #category : 'tests' }
GRPackageTest >> testName [
	self assert: package name isNil.
	package name: 'Gimme-Hope'.
	self assert: package name = 'Gimme-Hope'
]

{ #category : 'tests-packages' }
GRPackageTest >> testPackages [
	| packages |
	packages := GRPackage grPackages.
	self assert: packages notEmpty.
	packages do: [ :each | 
		self assert: each name notEmpty.
		self assert: each license notNil.
		self deny: (each dependencies includes: nil).
		self assert: each url notNil ].
]

{ #category : 'tests' }
GRPackageTest >> testUrl [
	self assert: package url isNil.
	
	package url: #seasideLGPLUrl.
	self assert: package url = GRPackage new seasideLGPLUrl. 
	
	package url: 'http://www.seaside.st/distributions'.
	self assert: package url = 'http://www.seaside.st/distributions'
]
