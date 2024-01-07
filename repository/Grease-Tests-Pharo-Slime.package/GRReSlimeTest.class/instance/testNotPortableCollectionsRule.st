tests-transform
testNotPortableCollectionsRule
	<expectedFailure>
	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'beginsWith1 ''abc'' beginsWith: ''a''' in: class.
	self compile: 'endsWith1 ''abc'' endsWith: ''a''' in: class.
	self 
		runTransformation: GRNotPortableCollectionsRule
		changes: #(
			'beginsWith1 ''abc'' greaseBeginsWith: ''a'''
			'endsWith1 ''abc'' greaseEndsWith: ''a''')