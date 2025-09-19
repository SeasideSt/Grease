*Grease-Tests-Pharo-Core
testIsGemStone
	self assert: GRPlatform current isGemStone.
	self deny: GRPlatform current isPharo.
	self deny: GRPlatform current isSqueak.
	self deny: GRPlatform current isVAST
