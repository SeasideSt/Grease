tests
testAccessors
	| version |
	version := self buildVersion: #(1 2 3 #alpha 4).
	self assert: version major = 1.
	self assert: version minor = 2.
	self assert: version revision = 3.
	self assert: version stage = #alpha.
	self assert: version stageNumber = 4.