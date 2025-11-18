Extension { #name : 'ScaledDecimal' }

{ #category : '*Grease-Pharo60-Core' }
ScaledDecimal >> encodeOn: aDocument [
	| converter |
	converter := GRSignPrinter new, (GRNumberPrinter new precision: self scale).
	converter print: self on: aDocument
]

{ #category : '*Grease-Pharo60-Core' }
ScaledDecimal >> greaseString [
	| converter |
	converter := GRSignPrinter new, (GRNumberPrinter new precision: self scale).
	^ converter print: self
]
