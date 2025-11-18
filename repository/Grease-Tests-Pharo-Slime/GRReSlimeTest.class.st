Class {
	#name : 'GRReSlimeTest',
	#superclass : 'TestCase',
	#instVars : [
		'model',
		'environment',
		'factory'
	],
	#category : 'Grease-Tests-Pharo-Slime',
	#package : 'Grease-Tests-Pharo-Slime'
}

{ #category : 'running-checks' }
GRReSlimeTest >> assertRule: aRuleClass matches: expectedMatches [

	self assertRule: aRuleClass matches: expectedMatches ignoring: Array new
]

{ #category : 'running-checks' }
GRReSlimeTest >> assertRule: aRuleClass matches: expectedMatches ignoring: ignoredRuleClasses [

	self run: aRuleClass ignoring: ignoredRuleClasses do: [ :critiques | | critiquedEntities |
		critiquedEntities := critiques collect:[ :critique | critique sourceAnchor entity ].
		critiquedEntities do:[ :critiquedEntity |
			self
				assert: (expectedMatches includes: critiquedEntity)
				description: ('{1} should not be reported' format: { critiquedEntity printString }) ].
		expectedMatches do: [ :expectedEntity |
			self
				assert: (critiquedEntities includes: expectedEntity)
				description: ('{1} should be reported' format: { expectedEntity printString }) ] ]
]

{ #category : 'accessing-code' }
GRReSlimeTest >> canParse: aString [

	RBParser
		parseMethod: aString
		onError: [ :err :pos | ^ false ].
	^ true
]

{ #category : 'accessing-code' }
GRReSlimeTest >> category [

	^ self class category , '-Data'
]

{ #category : 'accessing-code' }
GRReSlimeTest >> compile: aString in: aClass [

	GRPlatform current
		compile: aString
		into: aClass
		classified: #accessing
]

{ #category : 'accessing-code' }
GRReSlimeTest >> defineClass: aClassSymbol superclass: aSuperSymbol [
	"For compatibility"
	^ self defineSubClassOf: aSuperSymbol
]

{ #category : 'accessing-code' }
GRReSlimeTest >> defineSubClassOf: aSuperSymbol [

	^ self defineSubClassOf: aSuperSymbol inPackage: self category
]

{ #category : 'accessing-code' }
GRReSlimeTest >> defineSubClassOf: aSuperSymbol inPackage: packageName [

	| class |
	class := SystemVersion current major >= 12
		         ifTrue: [
			         factory make: [ :aBuilder |
				         aBuilder
					         superclass: (Smalltalk at: aSuperSymbol);
					         package: packageName ] ]
		         ifFalse: [
			         factory
				         newSubclassOf: (Smalltalk at: aSuperSymbol)
				         instanceVariableNames: ''
				         classVariableNames: 'classVarsString'
				         category: packageName ].
	environment
		addClass: class;
		addClass: class classSide.
	^ class
]

{ #category : 'running' }
GRReSlimeTest >> expectedFailures [

	SystemVersion current major >= 12 ifTrue:[ ^ #() ].
	
	^ #(#testEmptyStatements)
]

{ #category : 'running' }
GRReSlimeTest >> rules [

	^ (OrderedCollection new
		addAll: GRReSlimeBlockLintRule allSubclasses;
		addAll: GRReSlimeParseTreeLintRule allSubclasses;
		addAll: GRReSlimeTransformationRule allSubclasses;
		add: ReMultiplePeriodsTerminatingStatementRule;
		add: ReMethodSignaturePeriodRule;
		yourself) reject: #isAbstract
]

{ #category : 'running-checks' }
GRReSlimeTest >> run: aRuleClass ignoring: ignoredRuleClasses do: aBlock [

	| rules rule runner |
	rules := self rules
		collect: [ :each | each new ].
	rule := rules
		detect: [ :each | each isKindOf: aRuleClass ]
		ifNone: [ self error: ('{1} is not a slime rule' format: { aRuleClass name }) ].
	self
		assert: (rule name isString and: [ rule name notEmpty ])
		description: aRuleClass name , ' has no name'.
	self
		assert: (rule rationale isString and: [ rule rationale notEmpty and: [ rule rationale endsWithSubCollection: '.' ] ])
		description: aRuleClass name , ' has no rationale'.
	runner := ReSmalllintChecker new.
	rules do: [ :each |
		runner
			rule: { each };
			environment: environment;
			run ].
	rules do: [ :each | | result |
		result := runner criticsOf: each. 
		self 
			assert: (rule = each or: [ result isEmpty or: [ ignoredRuleClasses includes: each class ] ])
			description: ('{1} should not report errors' format: { each name })  ].
	aBlock value: (runner criticsOf: rule).
	^ rule
]

{ #category : 'running' }
GRReSlimeTest >> runCase [

	GRPlatform current doSilently: [ super runCase ]
]

{ #category : 'running-checks' }
GRReSlimeTest >> runTransformation: aClass changes: aCollection [

	| expected |
	expected := aCollection collect: [ :each | RBParser parseMethod: each ].
	self run: aClass ignoring: Array new do: [ :critiques | | changes |
		changes := critiques collect:[ :critique | critique change ].
		changes do: [ :change |
			self
				assert: (expected anySatisfy: [ :parseTree | change parseTree = parseTree ])
				description: ('{1} should not be transformed' format: { change selector }) ].
		expected do: [ :parseTree |
			self
				assert: (changes anySatisfy: [ :change | change parseTree = parseTree ])
				description: ('{1} should be transformed' format: { parseTree selector }) ] ]
]

{ #category : 'running' }
GRReSlimeTest >> setUp [

	super setUp.
	factory := ClassFactoryForTestCase new.
	model := RBNamespace new.
	environment := RBClassEnvironment new
]

{ #category : 'running' }
GRReSlimeTest >> tearDown [

	super tearDown.
	factory cleanUp
]

{ #category : 'tests-transform' }
GRReSlimeTest >> testAnsiBooleansRule [

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
GRReSlimeTest >> testAnsiCharacterRule [

	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'character Character value: 123' in: class.
	self compile: 'characterRange $a to: $c' in: class.
	self compile: 'integerRange 1 to: 10' in: class.
	self 
		runTransformation: GRAnsiCharactersRule
		changes: #('character Character codePoint: 123' 'characterRange ''abc''')
]

{ #category : 'tests-transform' }
GRReSlimeTest >> testAnsiCollectionsRule [

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
GRReSlimeTest >> testAnsiConditionalsRule [

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
GRReSlimeTest >> testAnsiConvertorRule [

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
GRReSlimeTest >> testAnsiExceptionsRule [

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
GRReSlimeTest >> testAnsiStreamsRule [

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
GRReSlimeTest >> testAnsiStringsRule [

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
GRReSlimeTest >> testBasicNewInitializeMissing [

	| class |
	class := self defineSubClassOf: #Object.
	self compile:  'initialize' in: class.
	self
		assertRule: GRBasicNewInitializeMissingRule
		matches: { class }
]

{ #category : 'tests-parsetree' }
GRReSlimeTest >> testDeprecatedApiProtocol [

	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'deprecated1 self greaseDeprecatedApi: ''',class name,'>>#deprecated1'' details: ''Something.''' in: class.
	self compile: 'deprecated2 self greaseDeprecatedApi: ''',class name,'>>#deprecated'' details: ''Something.''' in: class.
	self compile: 'deprecated3 self greaseDeprecatedApi: ''GRSlimeMock>>#deprecated3'' details: ''Something.''' in: class.
	self 
		assertRule: GRDeprecatedApiProtocolRule
		matches: { class>>#deprecated2 . class>>#deprecated3 }
]

{ #category : 'tests-block' }
GRReSlimeTest >> testEmptyStatements [
	"We added this test to make sure that this Pharo-supplied rule works because we previously had this one in Grease and it is important."

	| class |
	class := self defineSubClassOf: #GRObject.
	self compile: 'emptyStatement1.', (String with: Character cr), ' self and' in: class.
	self compile: 'emptyStatement2', (String with: Character cr), ' self and..' in: class.
	self compile: 'emptyStatement3', (String with: Character cr), ' self and."foo".' in: class.
	self compile: 'emptyStatement4', (String with: Character cr), ' self and."foo".self and' in: class.
	self 
		assertRule: ReMultiplePeriodsTerminatingStatementRule
		matches: { class>>#emptyStatement2 . class>>#emptyStatement3 . class>>#emptyStatement4 }
		ignoring: { ReMethodSignaturePeriodRule }.
	self 
		assertRule: ReMethodSignaturePeriodRule
		matches: { class>>#emptyStatement1 }
		ignoring: { ReMultiplePeriodsTerminatingStatementRule }.
]

{ #category : 'tests-block' }
GRReSlimeTest >> testInvalidObjectInitialization [

	| class |
	class := self defineSubClassOf: #GRObject.
	self compile:  'initializeFoo: aNumber' in: class.
	self 
		assertRule: GRInvalidObjectInitializationRule
		matches: { class>>#initializeFoo: }
]

{ #category : 'tests-block' }
GRReSlimeTest >> testNonPortableMessageRule [

	| class |
	class := self defineSubClassOf: #GRObject.

	self compile: 'invalid1 ^ Array new anyOne' in: class.
	self compile: 'valid1 ^ Array new first' in: class.

	self compile: 'invalid2 ^ Array new withIndexCollect: [ :each :index | each hash ]' in: class.
	self compile: 'valid2 ^ Array new do: [ :each | each hash ]' in: class.

	self 
		assertRule: GRNonPortableMessageRule
		matches: { class>>#invalid1 . class>>#invalid2 }
]

{ #category : 'tests-transform' }
GRReSlimeTest >> testNotPortableCollectionsRule [

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
GRReSlimeTest >> testObjectIn [

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

{ #category : 'tests-block' }
GRReSlimeTest >> testReferencesNotPortableClass [

	| class |
	class := self defineSubClassOf: #GRObject inPackage: 'SomeCategory'.
	self compile: 'invalid ^ Semaphore new' in: class.
	self compile: 'valid ^ GRObject new' in: class.
	self 
		assertRule: GRReferencesNotPortableClassRule
		matches: { class>>#invalid }
]

{ #category : 'tests-block' }
GRReSlimeTest >> testSubclassesNotPortableClass [

	| class |
	class := self defineSubClassOf: #Mutex inPackage: 'SomeCategory'.
	self 
		assertRule: GRSubclassesNotPortableClassRule
		matches: { class }
]

{ #category : 'tests-transform' }
GRReSlimeTest >> testTestCaseFailRule [

	| class |
	class := self defineSubClassOf: #TestCase.
	self compile: 'testMethod self fail' in: class.
	self 
		runTransformation: GRTestAssertionsRule
		changes: #( 'testMethod self assert: false' )
]

{ #category : 'tests-transform' }
GRReSlimeTest >> testTestCaseFailRule2 [

	| class |			
	class := self defineSubClassOf: #Object.
	self compile: 'method self fail' in: class.
	self 
		runTransformation: GRTestAssertionsRule
		changes: #( )
]

{ #category : 'tests-parsetree' }
GRReSlimeTest >> testUsesCanPerformOrUnderstand [

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
		assertRule: GRUsesCanPerformOrUnderstandRule
		matches: { class>>#invalid1 . class>>#invalid2 }
]

{ #category : 'tests-parsetree' }
GRReSlimeTest >> testUsesClassForHash [

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
		assertRule: GRUsesClassForHashRule
		matches: { class>>#hash }
]

{ #category : 'tests-block' }
GRReSlimeTest >> testUsesNotPortableClass [

	| class |
	class := self defineSubClassOf: #GRObject inPackage: 'SomeCategory'.
	self compile: 'invalid ^ Semaphore new' in: class.
	self compile: 'valid ^ GRObject new' in: class.
	self 
		assertRule: GRReferencesNotPortableClassRule
		matches: { class>>#invalid }
]
