tests-block
testDeprecatedApiProtocol
	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'deprecated1 self greaseDeprecatedApi: ''',class name,'>>#deprecated1'' details: ''Something.''' in: class.
	self compile: 'deprecated2 self greaseDeprecatedApi: ''',class name,'>>#deprecated'' details: ''Something.''' in: class.
	self compile: 'deprecated3 self greaseDeprecatedApi: ''GRSlimeMock>>#deprecated3'' details: ''Something.''' in: class.
	self 
		runRule: GRDeprecatedApiProtocolRule
		selectors: #(deprecated2 deprecated3)