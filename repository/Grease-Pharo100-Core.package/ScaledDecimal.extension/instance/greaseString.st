*Grease-Pharo100-Core
greaseString
	| converter |
	converter := GRSignPrinter new, (GRNumberPrinter new precision: self scale).
	^ converter print: self