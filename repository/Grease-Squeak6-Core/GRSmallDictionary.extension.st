Extension { #name : 'GRSmallDictionary' }

{ #category : '*grease-squeak6-core' }
GRSmallDictionary >> customizeExplorerContents [
	^ true
]

{ #category : '*grease-squeak6-core' }
GRSmallDictionary >> explorerContents [
	| contents |	
	contents := self keys sort: [ :a :b |  a compareSafely: b ].
	^contents replace: [ :key |
		ObjectExplorerWrapper
			with: (self at: key)
			name: (key printString contractTo: 32)
			model: self ].
]

{ #category : '*grease-squeak6-core' }
GRSmallDictionary >> hasContentsInExplorer [
	^ true
]
