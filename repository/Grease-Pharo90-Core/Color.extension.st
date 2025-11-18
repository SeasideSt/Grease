Extension { #name : 'Color' }

{ #category : '*Grease-Pharo90-Core' }
Color >> asHTMLColor [
	^'#', self asHexString
]
