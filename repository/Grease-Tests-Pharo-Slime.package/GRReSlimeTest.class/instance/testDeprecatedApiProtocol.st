tests-parsetree
testDeprecatedApiProtocol

	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'deprecated1 self greaseDeprecatedApi: ''',class name,'>>#deprecated1'' details: ''Something.''' in: class.
	self compile: 'deprecated2 self greaseDeprecatedApi: ''',class name,'>>#deprecated'' details: ''Something.''' in: class.
	self compile: 'deprecated3 self greaseDeprecatedApi: ''GRSlimeMock>>#deprecated3'' details: ''Something.''' in: class.
	self 
		assertRule: GRDeprecatedApiProtocolRule
		matches: { class>>#deprecated2 . class>>#deprecated3 }