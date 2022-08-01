tests
testThisContext
	| methodContext block ctx |
	"This is just a basic test to see if thisContext works"
	methodContext := self platform thisContext.
	block := [ | blockContext |
		blockContext := self platform thisContext.
		self assert: blockContext sender = methodContext.
		"The following is a difference between Gemstone and Pharo... "
		(Smalltalk includesKey: #GRGemStonePlatform)
			ifTrue: [ self assert: blockContext receiver = block ]
			ifFalse: [ 
				self assert: blockContext receiver = self.
				(blockContext respondsTo: #tempNamed:)
					ifTrue:[ self assert: (blockContext tempNamed: 'blockContext') == blockContext ]
					ifFalse:[ self assert:  (blockContext namedTempAt: (blockContext tempNames indexOf: #blockContext)) == blockContext ] ].
		(blockContext respondsTo: #tempNamed:)
			ifTrue:[ self assert: (blockContext tempNamed: 'methodContext') == methodContext ]
			ifFalse: [ self assert: (blockContext namedTempAt: (blockContext tempNames indexOf: #methodContext)) == methodContext ] ].
		
	block value.
	self assert: self returnSender = methodContext.
	self assert: methodContext receiver = self.
	ctx := self platform thisContext.
	(ctx respondsTo: #tempNamed:)
		ifTrue:[	self assert: (ctx tempNamed: 'block') == block ]
		ifFalse: [ self assert: (ctx namedTempAt: (ctx tempNames indexOf: #block)) == block ]