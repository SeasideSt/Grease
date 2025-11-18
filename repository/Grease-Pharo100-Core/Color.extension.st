Extension { #name : 'Color' }

{ #category : '*Grease-Pharo100-Core' }
Color >> asHTMLColor [
	^'#', self asHexString
]
