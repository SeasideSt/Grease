Extension { #name : 'ScaledDecimal' }

{ #category : '*Grease-Pharo70-Core' }
ScaledDecimal >> encodeOn: aDocument [
	| converter |
	converter := GRSignPrinter new, (GRNumberPrinter new precision: self scale).
	converter print: self on: aDocument
]

{ #category : '*Grease-Pharo70-Core' }
ScaledDecimal >> greaseString [
	| converter |
	converter := GRSignPrinter new, (GRNumberPrinter new precision: self scale).
	^ converter print: self
]
