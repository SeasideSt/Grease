initialization
initialize

	super initialize.
	self
		replace: 'Character value: ``@expr'
		with: 'Character codePoint: ``@expr'.
	self
		replace: '`#source to: `#target'
		byEvaluating: [ :node |
			(node receiver value isCharacter and: [
				 node arguments first value isCharacter ])
				ifTrue: [
					RBLiteralNode value: (String streamContents: [ :stream |
							 node receiver value codePoint to: node arguments first value codePoint do: [ :code | stream nextPut: (Character codePoint: code) ] ]) ]
				ifFalse: [ node ] ]