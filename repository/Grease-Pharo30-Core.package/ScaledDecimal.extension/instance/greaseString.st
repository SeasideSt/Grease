*Grease-Pharo30-Core
greaseString
	| converter |
	converter := GRNumberPrinter new precision: self scale.
	^ converter print: self