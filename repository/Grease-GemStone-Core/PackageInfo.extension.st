Extension { #name : 'PackageInfo' }

{ #category : '*grease-gemstone-core' }
PackageInfo >> versionString [
	| ancestor ancestors |
	ancestors := (MCPackage named: self name) workingCopy ancestry ancestors.
	ancestors isEmpty ifTrue: [ ^'unknown' ].
	ancestor := ancestors first.
	^ancestor name , '.mcz      ' , ancestor date printString, ' ', ancestor time printString
]
