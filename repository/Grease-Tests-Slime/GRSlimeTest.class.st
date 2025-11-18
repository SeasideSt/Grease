Class {
	#name : 'GRSlimeTest',
	#superclass : 'TestCase',
	#instVars : [
		'model',
		'environment',
		'factory'
	],
	#category : 'Grease-Tests-Slime',
	#package : 'Grease-Tests-Slime'
}

{ #category : 'accessing-code' }
GRSlimeTest >> canParse: aString [
	RBParser
		parseMethod: aString
		onError: [ :err :pos | ^ false ].
	^ true
]

{ #category : 'accessing' }
GRSlimeTest >> category [
	^ self class category , '-Data'
]

{ #category : 'accessing-code' }
GRSlimeTest >> compile: aString in: aClass [

	GRPlatform current
		compile: aString
		into: aClass
		classified: #accessing
]

{ #category : 'accessing-code' }
GRSlimeTest >> defineClass: aClassSymbol superclass: aSuperSymbol [
	"For compatibility"
	^ self defineSubClassOf: aSuperSymbol
]

{ #category : 'accessing-code' }
GRSlimeTest >> defineSubClassOf: aSuperSymbol [

	| class |
	class := SystemVersion current major >= 12
		         ifTrue: [
			         factory make: [ :aBuilder |
				         aBuilder
					         superclass: (Smalltalk at: aSuperSymbol);
					         package: self category ] ]
		         ifFalse: [
			         factory
				         newSubclassOf: (Smalltalk at: aSuperSymbol)
				         instanceVariableNames: ''
				         classVariableNames: 'classVarsString'
				         category: self category ].
	environment
		addClass: class;
		addClass: class theMetaClass.
	^ class
]

{ #category : 'accessing' }
GRSlimeTest >> rules [
	^ OrderedCollection new
		addAll: GRSlimeBlockLintRule allSubclasses;
		addAll: GRSlimeParseTreeLintRule allSubclasses;
		addAll: GRSlimeTransformationRule allSubclasses;
		yourself
]

{ #category : 'running-checks' }
GRSlimeTest >> run: aClass do: aBlock [
	| rules rule composite undo |
	rules := self rules
		collect: [ :each | each new ].
	rule := rules
		detect: [ :each | each isKindOf: aClass ]
		ifNone: [ self error: aClass name , ' is not a slime rule' ].
	self
		assert: (rule name isString and: [ rule name notEmpty ])
		description: aClass name , ' has no name'.
	self
		assert: (rule rationale isString and: [ rule rationale notEmpty and: [ rule rationale endsWithSubCollection: '.' ] ])
		description: aClass name , ' has no rationale'.
	composite := RBCompositeLintRule rules: rules name: 'Slime'.
	undo := model changes execute.
	[	RBSmalllintChecker runRule: composite onEnvironment: environment.
		rules do: [ :each |
			self 
				assert: (rule = each or: [ each result isEmpty and: [ each changes isEmpty ] ])
				description: each name , ' should not report errors' ].
		aBlock value: rule value: rules ]
			ensure: [ undo execute ].
	^ rule
]

{ #category : 'running-checks' }
GRSlimeTest >> run: aClass ignoring: aCollectionOfClasses do: aBlock [
	| rules rule composite undo |
	rules := self rules
		collect: [ :each | each new ].
	rule := rules
		detect: [ :each | each isKindOf: aClass ]
		ifNone: [ self error: aClass name , ' is not a slime rule' ].
	self
		assert: (rule name isString and: [ rule name notEmpty ])
		description: aClass name , ' has no name'.
	self
		assert: (rule rationale isString and: [ rule rationale notEmpty and: [ rule rationale endsWithSubCollection: '.' ] ])
		description: aClass name , ' has no rationale'.
	composite := RBCompositeLintRule rules: rules name: 'Slime'.
	undo := model changes execute.
	[	RBSmalllintChecker runRule: composite onEnvironment: environment.
		rules do: [ :each |
			self 
				assert: (rule = each or: [ (each result isEmpty and: [ each changes isEmpty ]) or: [ aCollectionOfClasses includes: each class ] ])
				description: each name , ' should not report errors' ].
		aBlock value: rule value: rules ]
			ensure: [ undo execute ].
	^ rule
]

{ #category : 'running' }
GRSlimeTest >> runCase [
	GRPlatform current doSilently: [ super runCase ]
]

{ #category : 'running-checks' }
GRSlimeTest >> runRule: aClass selectors: aCollection [
	self runRule: aClass selectors: aCollection ignoring: Array new
]

{ #category : 'running-checks' }
GRSlimeTest >> runRule: aClass selectors: aCollection ignoring: aCollectionOfClasses [
	self run: aClass ignoring: aCollectionOfClasses do: [ :rule :rules |
		rule result classesAndSelectorsDo: [ :class :selector |
			self
				assert: (aCollection includes: selector)
				description: selector printString , ' should not be reported' ].
		aCollection do: [ :selector |
			self
				assert: (rule result classes
					anySatisfy: [ :class | rule result includesSelector: selector in: class ])
				description: selector printString , ' should be reported' ] ]
]

{ #category : 'running-checks' }
GRSlimeTest >> runTransformation: aClass changes: aCollection [
	| expected |
	expected := aCollection 
		collect: [ :each | RBParser parseMethod: each ].
	self run: aClass ignoring: Array new do: [ :rule :rules |
		rule changes do: [ :change |
			self
				assert: (expected anySatisfy: [ :parseTree | change parseTree = parseTree ])
				description: change selector , ' should not be transformed' ].
		expected do: [ :parseTree |
			self
				assert: (rule changes anySatisfy: [ :change | change parseTree = parseTree ])
				description: parseTree selector , ' should be transformed' ] ]
]

{ #category : 'running' }
GRSlimeTest >> setUp [
	super setUp.
	factory := ClassFactoryForTestCase new.
	model := RBNamespace new.
	environment := RBClassEnvironment new
]

{ #category : 'running' }
GRSlimeTest >> tearDown [

	super tearDown.
	factory cleanUp
]

{ #category : 'tests-transform' }
GRSlimeTest >> testAnsiBooleansRule [
	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'and 1 and: [ 2 ] and: [ 3 ] and: [ 4 ]' in: class.
	self compile: 'or 1 or: [ 2 ] or: [ 3 ] or: [ 4 ]' in: class.
	self 
		runTransformation: GRAnsiBooleansRule
		changes: #(
			'and 1 and: [ 2 and: [ 3 and: [ 4 ] ] ]'
			'or 1 or: [ 2 or: [ 3 or: [ 4 ] ] ]' )
]

{ #category : 'tests-transform' }
GRSlimeTest >> testAnsiCharacterRule [
	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'character Character value: 123' in: class.
	self compile: 'characterRange $a to: $c' in: class.
	self 
		runTransformation: GRAnsiCharactersRule
		changes: #('character Character codePoint: 123' 'characterRange ''abc''')
]

{ #category : 'tests-transform' }
GRSlimeTest >> testAnsiCollectionsRule [
	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'withIndexDo #() withIndexDo: [ :each :index | each + index ]' in: class.
	self compile: 'doWithIndex #() doWithIndex: [ :each :index | each + index ]' in: class.
	self compile: 'collectThenDo #() collect: [ :a | a ] thenDo: [ :b | b ]' in: class.
	self compile: 'collectThenSelect #() collect: [ :a | a ] thenSelect: [ :b | true ]' in: class.
	self compile: 'detectSum #(1 2) detectSum: [ :each | each ]' in: class.
	self compile: 'detectSumMultiline #(1 2) detectSum: [ :each | #foo copy. each ]' in: class.
	self compile: 'pairsDo #(1 2 3 4) pairsDo: [ :a :b | b ]' in: class.
	self compile: 'rejectThenDo #() reject: [ :a | true ] thenDo: [ :b | b ]' in: class.
	self compile: 'selectThenCollect #() select: [ :a | true ] thenCollect: [ :b | b ]' in: class.
	self compile: 'selectThenDo #() select: [ :a | true ] thenDo: [ :b | b ]' in: class.
	self compile: 'valuesDo #() valuesDo: [ :a | a ]' in: class.
	self compile: 'reversed #() reversed' in: class.
	self compile: 'keysSortedSafely Dictionary new keysSortedSafely' in: class.
	self compile: 'newWithAll Array new: 4 withAll: $a' in: class.
	self 
		runTransformation: GRAnsiCollectionsRule
		changes: #( 
			'withIndexDo #() keysAndValuesDo: [ :index :each | each + index ]'
			'doWithIndex #() keysAndValuesDo: [ :index :each | each + index ]'
			'collectThenDo (#() collect: [ :a | a ]) do: [ :b | b ]'
			'selectThenDo (#() select: [ :a | true ]) do: [ :b | b ]'
			'rejectThenDo (#() reject: [ :a | true ]) do: [ :b | b ]'
			'selectThenCollect (#() select: [ :a | true ]) collect: [ :b | b ]'
			'pairsDo 1 to: #(1 2 3 4) size by: 2 do: [ :index | | a b | a := #(1 2 3 4) at: index. b := #(1 2 3 4) at: index + 1. b ]'
			'collectThenSelect (#() collect: [ :a | a ]) select: [ :b | true ]'
			'detectSum #(1 2) inject: 0 into: [ :sum :each | sum + each ]'
			'detectSumMultiline #(1 2) inject: 0 into: [ :sum :each | #foo copy. sum + each ]'
			'valuesDo #() do: [ :a | a ]'
			'reversed #() reverse'
			'keysSortedSafely Dictionary new keys asSortedCollection'
			'newWithAll (Array new: 4) atAllPut: $a'
			)
]

{ #category : 'tests-transform' }
GRSlimeTest >> testAnsiConditionalsRule [
	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'ifNotNil 1 ifNotNil: [ | a | self or. self and ]' in: class.
	self compile: 'ifNotNilDo 1 ifNotNilDo: [ :a | ^ a ]' in: class.
	self 
		runTransformation: GRAnsiConditionalsRule
		changes: #( 
			'ifNotNil 1 ifNotNil: [ :arg | | a | self or. self and ]'
			'ifNotNilDo 1 ifNotNil: [ :a | ^ a ]' )
]

{ #category : 'tests-transform' }
GRSlimeTest >> testAnsiConvertorRule [
	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'convertInteger ''1'' asInteger' in: class.
	self compile: 'convertString 2 asString' in: class.
	self 
		runTransformation: GRAnsiConvertorRule
		changes: #( 
			'convertInteger ''1'' greaseInteger'
			'convertString 2 greaseString' )
]

{ #category : 'tests-transform' }
GRSlimeTest >> testAnsiExceptionsRule [
	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'exception1 [ self or ] on: Error do: [ self or ]' in: class.
	self compile: 'exception2 [ self or ] on: Error do: [ self or. self or ]' in: class.
	self compile: 'exception3 [ self or ] on: Error do: [ | a | a := 0 ]' in: class.
	self 
		runTransformation: GRAnsiExceptionsRule
		changes: #( 
			'exception1 [ self or ] on: Error do: [ :err | self or ]'
			'exception2 [ self or ] on: Error do: [ :err | self or. self or ]'
			'exception3 [ self or ] on: Error do: [ :err | | a | a := 0 ]' )
]

{ #category : 'tests-transform' }
GRSlimeTest >> testAnsiStreamsRule [
	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'writeStream ^ '''' writeStream' in: class.
	self compile: 'writeCr | stream | stream := WriteStream on: ''''. stream cr. stream nextPut: Character cr' in: class.
	self compile: 'writeLf | stream | stream := WriteStream on: ''''. stream lf. stream nextPut: Character lf' in: class.
	self 
		runTransformation: GRAnsiStreamsRule
		changes: #( 
			'writeStream ^ WriteStream on: '''''
			'writeCr | stream | stream := WriteStream on: ''''. stream nextPut: Character cr. stream nextPut: Character cr'
			'writeLf | stream | stream := WriteStream on: ''''. stream nextPut: Character lf. stream nextPut: Character lf')
]

{ #category : 'tests-transform' }
GRSlimeTest >> testAnsiStringsRule [
	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'stringCr String cr, (String with: Character cr)' in: class.
	self compile: 'stringTab String tab, (String with: Character tab)' in: class.
	self compile: 'stringLf String lf, (String with: Character lf)' in: class.
	self compile: 'stringCrLf String crlf, (String with: Character cr with: Character lf)' in: class.
	self compile: 'stringSpace String space, (String with: Character space)' in: class.
	self compile: 'findTokens ''123'' findTokens: '',''' in: class.
	self compile: 'findTokensCharacter ''123'' findTokens: $,' in: class.
	self compile: 'findTokensArray ''123'' findTokens: #($, $;)' in: class.
	self compile: 'includesSubString ''1234'' includesSubString: ''23''' in: class.
	self compile: 'includesSubString ''1234'' includesSubstring: ''23''' in: class.
	self 
		runTransformation: GRAnsiStringsRule
		changes: #( 
			'stringCr (String with: Character cr), (String with: Character cr)'
			'stringTab (String with: Character tab), (String with: Character tab)'
			'stringLf (String with: Character lf), (String with: Character lf)'
			'stringCrLf (String with: Character cr with: Character lf), (String with: Character cr with: Character lf)'
			'stringSpace (String with: Character space), (String with: Character space)'
			'findTokens ''123'' subStrings: '','''
			'findTokensCharacter ''123'' subStrings: '',''' 
			'findTokensArray ''123'' subStrings: '',;'''
			'includesSubString (''1234'' indexOfSubCollection: ''23'' startingAt: 0) ~= 0'
			'includesSubString (''1234'' indexOfSubCollection: ''23'' startingAt: 0) ~= 0')
]

{ #category : 'tests-block' }
GRSlimeTest >> testBasicNewInitializeMissing [
	| class |
	class := self defineSubClassOf: #Object.
	self compile:  'initialize' in: class.
	self
		runRule: GRBasicNewInitializeMissingRule
		selectors: #(initialize)
]

{ #category : 'tests-parsetree' }
GRSlimeTest >> testBlockFormatting [
	| class |
	class := self defineSubClassOf: #GRObject.
	self 
		compile: 'invalid1
			[:a ]'
		in: class.
	self
		compile: 'invalid2
			[:a | ]'
		in: class.
	self
		compile: 'invalid3
			[ :b]'
		in: class.
	
	self
		compile: 'invalid4
			[ :a| ]'
		in: class.
	self
		compile: 'invalid5
			[ :a |a ]'
		in: class.
	self 
		runRule: GRBlockFormattingRule
		selectors: #(invalid1 invalid2 invalid3 invalid4 invalid5)
]

{ #category : 'tests-block' }
GRSlimeTest >> testDeprecatedApiProtocol [
	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'deprecated1 self greaseDeprecatedApi: ''',class name,'>>#deprecated1'' details: ''Something.''' in: class.
	self compile: 'deprecated2 self greaseDeprecatedApi: ''',class name,'>>#deprecated'' details: ''Something.''' in: class.
	self compile: 'deprecated3 self greaseDeprecatedApi: ''GRSlimeMock>>#deprecated3'' details: ''Something.''' in: class.
	self 
		runRule: GRDeprecatedApiProtocolRule
		selectors: #(deprecated2 deprecated3)
]

{ #category : 'tests-block' }
GRSlimeTest >> testInvalidObjectInitialization [
	| class |
	class := self defineSubClassOf: #GRObject.
	self compile:  'initializeFoo: aNumber' in: class.
	self 
		runRule: GRInvalidObjectInitializationRule
		selectors: #(initializeFoo:)
]

{ #category : 'tests-block' }
GRSlimeTest >> testNonPortableMessageRule [
	| class |
	class := self defineSubClassOf: #GRObject.

	self compile: 'invalid1 ^ Array new anyOne' in: class.
	self compile: 'valid1 ^ Array new first' in: class.

	self compile: 'invalid2 ^ Array new withIndexCollect: [ :each :index | each hash ]' in: class.
	self compile: 'valid2 ^ Array new do: [ :each | each hash ]' in: class.

	self 
		runRule: GRNonPortableMessageRule
		selectors: #(invalid1 invalid2)
]

{ #category : 'tests-block' }
GRSlimeTest >> testNonPortableSourceFormat [
	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'invalid ^ ''Unicode snow man', (String with: (Character codePoint: 16r2603)) , '''' in: class.
	self compile: 'valid ^ ''everything is fine''' in: class.
	self 
		runRule: GRNonPortableSourceFormatRule
		selectors: #(invalid)
]

{ #category : 'tests-transform' }
GRSlimeTest >> testNotPortableCollectionsRule [
	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'beginsWith1 ''abc'' beginsWith: ''a''' in: class.
	self compile: 'endsWith1 ''abc'' endsWith: ''a''' in: class.
	self 
		runTransformation: GRNotPortableCollectionsRule
		changes: #(
			'beginsWith1 ''abc'' greaseBeginsWith: ''a'''
			'endsWith1 ''abc'' greaseEndsWith: ''a''')
]

{ #category : 'tests-transform' }
GRSlimeTest >> testObjectIn [
	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'objectIn1 1 in: [ :val | val factorial ]' in: class.
	self compile: 'objectIn2 2 in: [ :val | | temps | val factorial ]' in: class.
	self compile: 'objectIn3 2 in: [ ''not this'' ]' in: class.
	self 
		runTransformation: GRObjectInRule
		changes: #(
			'objectIn1 [ :val | val factorial ] value: 1'
			'objectIn2 [ :val | | temps | val factorial ] value: 2')
]

{ #category : 'tests-parsetree' }
GRSlimeTest >> testParensFormatting [
	| class |
	class := self defineSubClassOf: #GRObject.
	self
		compile: 'invalid1
			( 1 + 2)'
		in: class.
	self
		compile: 'invalid2
			(1 + 2 )'
		in: class.
	self 
		runRule: GRParensFormattingRule
		selectors: #(invalid1 invalid2)
]

{ #category : 'tests-parsetree' }
GRSlimeTest >> testReturnFormatting [
	| class |
	class := self defineSubClassOf: #GRObject.
	self
		compile: 'invalid1
			^1'
		in: class.
	self
		compile: 'invalid2
			^  2'
		in: class.
	self 
		runRule: GRReturnFormattingRule
		selectors: #(invalid1 invalid2)
]

{ #category : 'tests-parsetree' }
GRSlimeTest >> testTempsFormatting [
	| class |
	class := self defineSubClassOf: #GRObject.
	self
		compile: 'invalid1
			| a|'
		in: class.
	self
		compile: 'invalid2
			|a |'
		in: class.
	self
		compile: 'invalid3
			| a  b |'
		in: class.
	self 
		runRule: GRTempsFormattingRule
		selectors: #(invalid1 invalid2 invalid3)
]

{ #category : 'tests-transform' }
GRSlimeTest >> testTestCaseFailRule [
	| class |
	class := self defineSubClassOf: #TestCase.
	self compile: 'testMethod self fail' in: class.
	self 
		runTransformation: GRTestAssertionsRule
		changes: #(
			'testMethod self assert: false' )
]

{ #category : 'tests-block' }
GRSlimeTest >> testUnnecessaryLastPeriodRule [
	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'invalid 1. 2.' in: class.
	self compile: 'valid 1. 2' in: class.
	self 
		runRule: GRUnnecessaryLastPeriodRule
		selectors: #(invalid)
]

{ #category : 'tests-parsetree' }
GRSlimeTest >> testUsesCanPerformOrUnderstand [
	| class |
	class := self defineSubClassOf: #GRObject.
	self
		compile: 'invalid1
			Object class canUnderstand: #new'
		in: class.
	self
		compile: 'invalid2
			Object class canPerform: #new'
		in: class.
	self
		compile: 'valid
			Object respondsTo: #new'
		in: class.
	self 
		runRule: GRUsesCanPerformOrUnderstandRule
		selectors: #(invalid1 invalid2)
]

{ #category : 'tests-parsetree' }
GRSlimeTest >> testUsesClassForHash [
	| class |
	class := self defineSubClassOf: #GRObject.
	self
		compile: 'foo
			^ super hash bitXor: self class hash'
		in: class.
	self
		compile: 'hash
			^ super hash bitXor: self class hash'
		in: class.
	self 
		runRule: GRUsesClassForHashRule
		selectors: #(hash)
]

{ #category : 'tests-parsetree' }
GRSlimeTest >> testUsesCurlyBraceArrays [
	| class |
	(self canParse: 'foo { self foo. self bar }')
		ifFalse: [ ^ self ].
	class := self defineSubClassOf: #GRObject.
	self
		compile: 'invalid
			^ { self foo. self bar }'
		in: class.
	self
		compile: 'valid
			^ Array new'
		in: class.
	self 
		runRule: GRUsesCurlyBraceArraysRule
		selectors: #(invalid)
]

{ #category : 'tests-block' }
GRSlimeTest >> testUsesMethodAnnotations [
	| class |
	(self canParse: 'foo <foo: 123>')
		ifFalse: [ ^ self ].
	class := self defineSubClassOf: #GRObject.
	self compile: 'invalid <foo: 123>' in: class.
	self compile: 'valid' in: class.
	self 
		runRule: GRUsesMethodAnnotationsRule
		selectors: #(invalid)
]

{ #category : 'tests-block' }
GRSlimeTest >> testUsesNotPortableClass [
	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'invalid ^ Semaphore new' in: class.
	self compile: 'valid ^ GRObject new' in: class.
	self 
		runRule: GRUsesNotPortableClassRule
		selectors: #(invalid)
]
