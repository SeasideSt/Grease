Class {
	#name : 'GRStringTest',
	#superclass : 'GRAbstractSequenceableCollectionTest',
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'configuration' }
GRStringTest >> allowsDuplicateValues [
	^ true
]

{ #category : 'configuration' }
GRStringTest >> arbitraryCollection [
	^ 'fadbbc' copy   "String literals are immutable"
]

{ #category : 'configuration' }
GRStringTest >> collectionClass [
	^ String
]

{ #category : 'configuration' }
GRStringTest >> duplicateElement [
	^ $b
]

{ #category : 'configuration' }
GRStringTest >> excludedElement [
	^ $Q
]

{ #category : 'configuration' }
GRStringTest >> includedElement [
	^ $d
]

{ #category : 'testing-ansi' }
GRStringTest >> isExtensible [
	^ false
]

{ #category : 'testing' }
GRStringTest >> isHomogeneous [
	^ true
]

{ #category : 'testing-ansi' }
GRStringTest >> isInitializable [
	^ true
]

{ #category : 'testing-ansi' }
GRStringTest >> isSequenced [
	^ true
]

{ #category : 'testing' }
GRStringTest >> isUnique [
	^ false
]

{ #category : 'tests-converting' }
GRStringTest >> testAsUppercase [
	self assert: 'abc' asUppercase = 'ABC'.
	self assert: 'ABC' asUppercase = 'ABC'
]

{ #category : 'tests-converting' }
GRStringTest >> testCapitalized [
	self assert: 'capitalized' capitalized = 'Capitalized'.
	self assert: 'Capitalized' capitalized = 'Capitalized'.
	self assert: 'CAPITALIZED' capitalized = 'CAPITALIZED'.
	self assert: #'capitalized' capitalized = #'Capitalized'.
	self assert: #'Capitalized' capitalized = #'Capitalized'.
	self assert: #'CAPITALIZED' capitalized = #'CAPITALIZED'
]

{ #category : 'tests-converting' }
GRStringTest >> testCapitalizedUmlauts [
	self assert: 'äöü' capitalized = 'Äöü'.
	self assert: 'Äöü' capitalized = 'Äöü'.
	self assert: 'ÄÖÜ' capitalized = 'ÄÖÜ'.
	self assert: #'äöü' capitalized = #'Äöü'.
	self assert: #'Äöü' capitalized = #'Äöü'.
	self assert: #'ÄÖÜ' capitalized = #'ÄÖÜ'
]

{ #category : 'tests-excerpt' }
GRStringTest >> testExcerpt [
	self assert: ('abcde' excerpt: 'c' radius: 0) = '...c...'.
	self assert: ('abcde' excerpt: 'c' radius: 1) = '...bcd...'.
	self assert: ('abcde' excerpt: 'c' radius: 2) = 'abcde'.
	self assert: ('abcde' excerpt: 'c' radius: 3) = 'abcde'.
	
	self assert: ('abcde' excerpt: 'c' radius: 0 ellipsis: 'x') = 'xcx'.
	self assert: ('abcde' excerpt: 'c' radius: 1 ellipsis: 'x') = 'xbcdx'.
	self assert: ('abcde' excerpt: 'c' radius: 2 ellipsis: 'x') = 'abcde'
]

{ #category : 'tests-excerpt' }
GRStringTest >> testExcerptEmpty [
	self assert: ('' excerpt: '') isNil.
	self assert: ('' excerpt: 'x') isNil.
	self assert: ('x' excerpt: '') isNil
]

{ #category : 'tests-excerpt' }
GRStringTest >> testExcerptLeft [
	self assert: ('abcde' excerpt: 'd' radius: 0 ellipsis: 'x') = 'xdx'.
	self assert: ('abcde' excerpt: 'd' radius: 1 ellipsis: 'x') = 'xcde'.
	self assert: ('abcde' excerpt: 'd' radius: 2 ellipsis: 'x') = 'xbcde'.
	self assert: ('abcde' excerpt: 'd' radius: 3 ellipsis: 'x') = 'abcde'
]

{ #category : 'tests-excerpt' }
GRStringTest >> testExcerptRight [
	self assert: ('abcde' excerpt: 'b' radius: 0 ellipsis: 'x') = 'xbx'.
	self assert: ('abcde' excerpt: 'b' radius: 1 ellipsis: 'x') = 'abcx'.
	self assert: ('abcde' excerpt: 'b' radius: 2 ellipsis: 'x') = 'abcdx'.
	self assert: ('abcde' excerpt: 'b' radius: 3 ellipsis: 'x') = 'abcde'
]

{ #category : 'tests-pluralize' }
GRStringTest >> testInflectorAssimilated [
	self assert: 'vertice' pluralize = 'vertices'.
	self assert: 'index' pluralize = 'indices'
]

{ #category : 'tests-pluralize' }
GRStringTest >> testInflectorCommonSuffixes [
	self assert: 'mouse' pluralize = 'mice'.
	self assert: 'synopse' pluralize = 'synopses'.
	self assert: 'man' pluralize = 'men'
]

{ #category : 'tests-pluralize' }
GRStringTest >> testInflectorFfffSuffixes [
	self assert: 'life' pluralize = 'lives'.
	self assert: 'wolf' pluralize = 'wolves'
]

{ #category : 'tests-pluralize' }
GRStringTest >> testInflectorIrregular [
	self assert: 'genie' pluralize = 'genies'.
	self assert: 'ox' pluralize = 'oxen'.
	self assert: 'cow' pluralize = 'kine'.
	self assert: 'child' pluralize = 'children'.
	self assert: 'woman' pluralize = 'women'
]

{ #category : 'tests-pluralize' }
GRStringTest >> testInflectorNotInflecting [
	self assert: 'fish' pluralize = 'fish'.
	self assert: 'travois' pluralize = 'travois'.
	self assert: 'chassis' pluralize = 'chassis'.
	self assert: 'nationalities' pluralize = 'nationalities'
]

{ #category : 'tests-pluralize' }
GRStringTest >> testInflectorTsssSuffixes [
	self assert: 'church' pluralize = 'churches'.
	self assert: 'class' pluralize = 'classes'
]

{ #category : 'tests-pluralize' }
GRStringTest >> testInflectorYyyySuffixes [
	self assert: 'story' pluralize = 'stories'.
	self assert: 'lady' pluralize = 'ladies'.
	self assert: 'stay' pluralize = 'stays'
]

{ #category : 'tests' }
GRStringTest >> testSubStrings [
	"#subStrings: is defined by ANSI 5.7.10.15:
	Answer an array containing the substrings in the receiver separated by the elements of separators."
	| mimeType tokens |
	mimeType := 'application/xhtml+xml'.
	tokens := mimeType substrings: '/'.
	self assert: tokens size = 2.
	self assert: tokens first = 'application'.
	self assert: tokens second = 'xhtml+xml'.
	
	"ANSI is a bit unclear on how multiple sequential delimiters should be treated.
	Make sure behaviour is consistent for several delimiters in a row (taken from
	Squeak's behaviour)"
	tokens := 'abc,.def.ghi' substrings: '.,'.
	self assert: tokens size = 3.
	self assert: tokens first = 'abc'.
	self assert: tokens second = 'def'.
	self assert: tokens third = 'ghi'.

	"also ensure behavior consistent for several delimiters in a row at beginning and end of string...for completeness"
	tokens := ',.abc,.def.ghi.,' substrings: '.,'.
	self assert: tokens size = 3.
	self assert: tokens first = 'abc'.
	self assert: tokens second = 'def'.
	self assert: tokens third = 'ghi'
]

{ #category : 'tests-trim' }
GRStringTest >> testTrimBoth [
	self assert: '' trimBoth = ''.
	self assert: ' ' trimBoth = ''.
	self assert: '	' trimBoth = ''.
	self assert: 'foo' trimBoth = 'foo'.
	self assert: ' foo ' trimBoth = 'foo'.
	self assert: '  foo  ' trimBoth = 'foo'.
	self assert: ((String with: Character cr), '   foo  ') trimBoth = 'foo'.
	
	self assert: ('aabbaa' trimBoth: [ :each | each = $a ]) = 'bb'.
	self assert: ('bbaabb' trimBoth: [ :each | each = $a ]) = 'bbaabb'
]

{ #category : 'tests-trim' }
GRStringTest >> testTrimLeft [
	self assert: '' trimLeft = ''.
	self assert: ' ' trimLeft = ''.
	self assert: '	' trimLeft = ''.
	self assert: 'foo' trimLeft = 'foo'.
	self assert: ' foo ' trimLeft = 'foo '.
	self assert: '  foo  ' trimLeft = 'foo  '.
	
	self assert: ('aabbaa' trimLeft: [ :each | each = $a ]) = 'bbaa'.
	self assert: ('bbaabb' trimLeft: [ :each | each = $a ]) = 'bbaabb'
]

{ #category : 'tests-trim' }
GRStringTest >> testTrimRight [
	self assert: '' trimRight = ''.
	self assert: ' ' trimRight = ''.
	self assert: '	' trimRight = ''.
	self assert: 'foo' trimRight = 'foo'.
	self assert: ' foo ' trimRight = ' foo'.
	self assert: '  foo  ' trimRight = '  foo'.
	
	self assert: ('aabbaa' trimRight: [ :each | each = $a ]) = 'aabb'.
	self assert: ('bbaabb' trimRight: [ :each | each = $a ]) = 'bbaabb'
]

{ #category : 'tests-truncate' }
GRStringTest >> testTruncate [
	self assert: ('abc' truncate) = 'abc'.
	self assert: ('abc' truncate: 3) = 'abc'.
	self assert: ('abc' truncate: 2) = 'ab...'.
	
	self assert: ('abc' truncate: 1 ellipsis: '') = 'a'.
	self assert: ('abc' truncate: 0 ellipsis: 'none') = 'none'
]

{ #category : 'tests-truncate' }
GRStringTest >> testTruncateEmpty [
	self assert: '' truncate = ''
]
