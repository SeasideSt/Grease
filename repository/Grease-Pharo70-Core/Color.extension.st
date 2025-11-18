Extension { #name : 'Color' }

{ #category : '*Grease-Pharo70-Core' }
Color >> asHTMLColor [
	^'#', self asHexString
]
