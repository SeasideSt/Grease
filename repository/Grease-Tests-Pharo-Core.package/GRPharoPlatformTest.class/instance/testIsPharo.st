*Grease-Tests-Pharo-Core
testIsPharo
	self assert: GRPlatform current isPharo.
	self deny: GRPlatform current isGemStone.
	self deny: GRPlatform current isSqueak.
	self deny: GRPlatform current isVAST
