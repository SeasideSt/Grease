Extension { #name : 'GRStringTest' }

{ #category : '*grease-tests-gemstone-core' }
GRStringTest >> multiByteConvert: aString [

	^self collectionClass withAll: aString
]

{ #category : '*grease-tests-gemstone-core' }
GRStringTest >> testMultiByteCapitalized [
	self assert: (self multiByteConvert: 'capitalized') capitalized = 'Capitalized'.
	self assert: (self multiByteConvert: 'Capitalized') capitalized = 'Capitalized' .
	self assert: (self multiByteConvert: 'CAPITALIZED') capitalized = 'CAPITALIZED' .
]

{ #category : '*grease-tests-gemstone-core' }
GRStringTest >> testMultiByteExcerpt [
	self assert: ((self multiByteConvert: 'abcde') excerpt: 'c' radius: 0) = '...c...'.
	self assert: ((self multiByteConvert: 'abcde') excerpt: 'c' radius: 1) = '...bcd...'.
	self assert: ((self multiByteConvert: 'abcde') excerpt: 'c' radius: 2) = (self multiByteConvert: 'abcde').
	self assert: ((self multiByteConvert: 'abcde') excerpt: 'c' radius: 3) = (self multiByteConvert: 'abcde').
	
	self assert: ((self multiByteConvert: 'abcde') excerpt: 'c' radius: 0 ellipsis: 'x') = 'xcx'.
	self assert: ((self multiByteConvert: 'abcde') excerpt: 'c' radius: 1 ellipsis: 'x') = 'xbcdx'.
	self assert: ((self multiByteConvert: 'abcde') excerpt: 'c' radius: 2 ellipsis: 'x') = (self multiByteConvert: 'abcde')
]

{ #category : '*grease-tests-gemstone-core' }
GRStringTest >> testMultiByteSubStrings [
	"#subStrings: is defined by ANSI 5.7.10.15:
	Answer an array containing the substrings in the receiver separated by the elements of separators."
	| mimeType tokens |
	mimeType := (self multiByteConvert: 'application/xhtml+xml').
	tokens := mimeType subStrings: '/'.
	self assert: tokens size = 2.
	self assert: tokens first = 'application'.
	self assert: tokens second = 'xhtml+xml'.
	
	"ANSI is a bit unclear on how multiple sequential delimiters should be treated.
	Make sure behaviour is consistent for several delimiters in a row (taken from
	Squeak's behaviour)"
	tokens := (self multiByteConvert: 'abc,.def.ghi') subStrings: '.,'.
	self assert: tokens size = 3.
	self assert: tokens first = 'abc'.
	self assert: tokens second = 'def'.
	self assert: tokens third = 'ghi'.

	"also ensure behavior consistent for several delimiters in a row at beginning and end of string...for completeness"
	tokens := (self multiByteConvert: ',.abc,.def.ghi.,') subStrings: '.,'.
	self assert: tokens size = 3.
	self assert: tokens first = 'abc'.
	self assert: tokens second = 'def'.
	self assert: tokens third = 'ghi'.
]

{ #category : '*grease-tests-gemstone-core' }
GRStringTest >> testMultiByteTrimBoth [
	self assert: (self multiByteConvert: '') trimBoth = ''.
	self assert: (self multiByteConvert: ' ') trimBoth = ''.
	self assert: (self multiByteConvert: '	') trimBoth = ''.
	self assert: (self multiByteConvert: 'foo') trimBoth = 'foo'.
	self assert: (self multiByteConvert: ' foo ') trimBoth = 'foo'.
	self assert: (self multiByteConvert: '  foo  ') trimBoth = 'foo'.
	self assert: ((self collectionClass with: Character cr), '   foo  ') trimBoth = 'foo'.
	
	self assert: ((self multiByteConvert: 'aabbaa') trimBoth: [ :each | each = $a ]) = 'bb'.
	self assert: ((self multiByteConvert: 'bbaabb') trimBoth: [ :each | each = $a ]) = 'bbaabb'
]

{ #category : '*grease-tests-gemstone-core' }
GRStringTest >> testMultiByteTruncate [
	self assert: ((self multiByteConvert: 'abc') truncate) = (self multiByteConvert: 'abc').
	self assert: ((self multiByteConvert: 'abc') truncate: 3) = (self multiByteConvert: 'abc').
	self assert: ((self multiByteConvert: 'abc') truncate: 2) = 'ab...'.
	
	self assert: ((self multiByteConvert: 'abc') truncate: 1 ellipsis: '') = 'a'.
	self assert: ((self multiByteConvert: 'abc') truncate: 0 ellipsis: 'none') = 'none'
]
