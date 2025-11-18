Extension { #name : 'ScaledDecimal' }

{ #category : '*Grease-Pharo90-Core' }
ScaledDecimal >> encodeOn: aDocument [
	| converter |
	converter := GRSignPrinter new, (GRNumberPrinter new precision: self scale).
	converter print: self on: aDocument
]

{ #category : '*Grease-Pharo90-Core' }
ScaledDecimal >> greaseString [
	| converter |
	converter := GRSignPrinter new, (GRNumberPrinter new precision: self scale).
	^ converter print: self
]
