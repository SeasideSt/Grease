tests
testThisContext
	| methodContext block |
	methodContext := self platform thisContext.
	block := [ | blockContext |
	blockContext := self platform thisContext.
	self assert: blockContext sender = methodContext.
	"The following is a difference between Gemstone and Pharo... "
	(Smalltalk includesKey: #GRGemStonePlatform)
		ifTrue: [ self assert: blockContext receiver = block ]
		ifFalse: [ 
			self assert: blockContext receiver = self.
			self assert: (blockContext namedTempAt: (blockContext tempNames indexOf: #blockContext)) == blockContext ].
	self assert: (blockContext namedTempAt: (blockContext tempNames indexOf: #methodContext)) == methodContext ].
	block value.
	self assert: self returnSender = methodContext.
	self assert: methodContext receiver = self.
	self assert: (self platform thisContext namedTempAt: (self platform thisContext tempNames indexOf: #block)) == block