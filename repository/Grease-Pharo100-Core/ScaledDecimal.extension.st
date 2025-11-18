Extension { #name : 'ScaledDecimal' }

{ #category : '*Grease-Pharo100-Core' }
ScaledDecimal >> encodeOn: aDocument [
	| converter |
	converter := GRSignPrinter new, (GRNumberPrinter new precision: self scale).
	converter print: self on: aDocument
]

{ #category : '*Grease-Pharo100-Core' }
ScaledDecimal >> greaseString [
	| converter |
	converter := GRSignPrinter new, (GRNumberPrinter new precision: self scale).
	^ converter print: self
]
