*Grease-Pharo120-Core
encodeOn: aDocument
	| converter |
	converter := GRSignPrinter new, (GRNumberPrinter new precision: self scale).
	converter print: self on: aDocument