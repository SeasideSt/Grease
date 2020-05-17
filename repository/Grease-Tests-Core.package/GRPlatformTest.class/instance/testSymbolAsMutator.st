tests
testSymbolAsMutator
	"test for:
	Symbol >> #asMutator
	^ (self copyWith: $:) asSymbol"
	self assert: #name greaseAsMutator = #name: