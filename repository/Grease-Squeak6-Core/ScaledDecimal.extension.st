Extension { #name : 'ScaledDecimal' }

{ #category : '*grease-squeak6-core' }
ScaledDecimal >> encodeOn: aDocument [
	"not the ideal package but we don't have a Seaside-Squeak-Core"
	| converter |
	converter := GRSignPrinter new, (GRNumberPrinter new precision: self scale).
	converter print: self on: aDocument
]

{ #category : '*grease-squeak6-core' }
ScaledDecimal >> greaseString [
	| converter |
	converter := GRSignPrinter new, (GRNumberPrinter new precision: self scale).
	^ converter print: self
]
