Extension { #name : 'Color' }

{ #category : '*Grease-Pharo60-Core' }
Color >> asHTMLColor [
	^'#', self asHexString
]
