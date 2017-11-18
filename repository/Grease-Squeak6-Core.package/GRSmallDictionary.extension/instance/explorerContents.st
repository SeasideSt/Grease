*grease-squeak6-core
explorerContents
	| contents |	
	contents := self keys sort: [ :a :b |  a compareSafely: b ].
	^contents replace: [ :key |
		ObjectExplorerWrapper
			with: (self at: key)
			name: (key printString contractTo: 32)
			model: self ].