*grease-pharo20-core
greaseString
	| converter |
	converter := GRNumberPrinter new precision: self scale.
	^ converter print: self