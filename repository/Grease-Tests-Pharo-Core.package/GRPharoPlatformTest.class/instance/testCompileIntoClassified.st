tests
testCompileIntoClassified

	| source protocol selectors selector |
	source := 'aMethod
	^ ''a result'''.
	protocol := 'a-protocol'.
	selector := #aMethod.
	GRPlatform current
		compile: source
		into: self class
		classified: protocol.

	[
	self assert: (self class selectors includes: selector).
	selectors := GRPlatform current
		selectorsInProtocol: protocol
		ofClass: self class.
	self assert: selectors equals: (Array with: selector) ] ensure: [
		self class removeSelector: selector ]