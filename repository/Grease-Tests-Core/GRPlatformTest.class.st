"
A GRPlatformTest is a test to make sure the platform (= the Smalltalk dialect we are running on) implements the protocol we need for system classes like Collection. An example would be to make sure Collection implements #count: with the semantics we need.
"
Class {
	#name : 'GRPlatformTest',
	#superclass : 'TestCase',
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'private' }
GRPlatformTest >> decodeUtf8Character: aCollectionOfIntegers [ 
	"Decodes a collection of bytes into a single character. We have this so we can avoid having non-ASCII characters in the source."
	| codec toDecode decoded |
	codec := GRCodec forEncoding: 'utf-8'.
	toDecode := aCollectionOfIntegers asByteArray.
	decoded := codec decode: toDecode.
	self assert: decoded size = 1.
	^ decoded first
]

{ #category : 'accessing' }
GRPlatformTest >> platform [
	<ignoreForCoverage>
	^ GRPlatform current
]

{ #category : 'private' }
GRPlatformTest >> returnSender [
	<ignoreForCoverage>
	^ GRPlatform current thisContext sender
]

{ #category : 'running' }
GRPlatformTest >> runCase [
	GRPlatform current doSilently: [ super runCase ]
]

{ #category : 'tests' }
GRPlatformTest >> testAsNumber [
	self assert: 2007 asNumber = 2007.
	self assert: '2007' asNumber = 2007
]

{ #category : 'tests-encoding' }
GRPlatformTest >> testBase64Decode [
	| input |
	input := #(
		'YW55IGNhcm5hbCBwbGVhc3VyZS4='  'any carnal pleasure.'
		'YW55IGNhcm5hbCBwbGVhc3VyZQ==' 'any carnal pleasure'
		'YW55IGNhcm5hbCBwbGVhc3Vy' 'any carnal pleasur'
		'YW55IGNhcm5hbCBwbGVhc3U=' 'any carnal pleasu'
		'YW55IGNhcm5hbCBwbGVhcw==' 'any carnal pleas').
	1 to: input size by: 2 do: [ :index |
		| decoded expected |
		decoded := GRPlatform current base64Decode: (input at: index).
		expected := input at: index + 1.
		self assert: decoded = expected ]
]

{ #category : 'tests-encoding' }
GRPlatformTest >> testBase64Encode [
	| input |
	input := #(
		(97 110 121 32 99 97 114 110 97 108 32 112 108 101 97 115 117 114 101 46) 'YW55IGNhcm5hbCBwbGVhc3VyZS4=' 
		(97 110 121 32 99 97 114 110 97 108 32 112 108 101 97 115 117 114 101) 'YW55IGNhcm5hbCBwbGVhc3VyZQ=='
		(97 110 121 32 99 97 114 110 97 108 32 112 108 101 97 115 117 114) 'YW55IGNhcm5hbCBwbGVhc3Vy'
		(97 110 121 32 99 97 114 110 97 108 32 112 108 101 97 115 117) 'YW55IGNhcm5hbCBwbGVhc3U=' 
		(97 110 121 32 99 97 114 110 97 108 32 112 108 101 97 115) 'YW55IGNhcm5hbCBwbGVhcw==').
	1 to: input size by: 2 do: [ :index |
		| decoded expected |
		decoded := GRPlatform current base64Encode: (input at: index) asByteArray.
		expected := input at: index + 1.
		self assert: decoded = expected ]
]

{ #category : 'tests' }
GRPlatformTest >> testBindingOf [
	| binding |
	binding := GRPlatform current bindingOf: GRPlatform.
	self assert: binding value == GRPlatform
]

{ #category : 'tests' }
GRPlatformTest >> testBlockContextWithPossibleArguments [
	| block |
	block := [ :x | 1 + x ].
	self assert: (block valueWithPossibleArguments: (Array with: 2)) = 3.

	block := [ false not ].
	self assert: (block valueWithPossibleArguments: (Array with: 3))
]

{ #category : 'tests' }
GRPlatformTest >> testBlockValuableProtocol [
	self assert: [ nil ] argumentCount isZero.
	self assert: [ :x | x ] argumentCount = 1.
	self assert: [ :a :b | a + b ] argumentCount = 2.
	self 
		shouldnt: [ [ nil ] ]
		raise: Error.
	self 
		shouldnt: [ [ :x | x ] ]
		raise: Error.
	self 
		shouldnt: [ [ :a :b | a + b ] ]
		raise: Error
]

{ #category : 'tests' }
GRPlatformTest >> testCharacterAsUnicode [
	"test for:
	Character >> #asUnicode
		^self asInteger"
	self assert: $S asUnicode = 83
]

{ #category : 'tests' }
GRPlatformTest >> testCharacterTo [
	| actual expected |
	actual := Array withAll: 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-'.
	actual := actual collect: [ :each | each greaseInteger ].
	expected := #(
		97
		98
		99
		100
		101
		102
		103
		104
		105
		106
		107
		108
		109
		110
		111
		112
		113
		114
		115
		116
		117
		118
		119
		120
		121
		122
		65
		66
		67
		68
		69
		70
		71
		72
		73
		74
		75
		76
		77
		78
		79
		80
		81
		82
		83
		84
		85
		86
		87
		88
		89
		90
		48
		49
		50
		51
		52
		53
		54
		55
		56
		57
		95
		45
	).
	self assert: actual size = expected size.
	actual 
		with: expected
		do: [ :first :second | self assert: first = second ]
]

{ #category : 'tests-mop' }
GRPlatformTest >> testCompileAsciiString [
	| selector expected source |
	
	GRPlatform current supportsUnicode ifFalse: [
		^ self ].
	
	selector := #stringMethod.
	expected := 'test ok'.
	source := GRPlatform current asMethodReturningString: expected named: selector.
	[ 
		| actual |
		GRPlatform current compile: source into: self class classified: 'private'.
		actual := self perform: selector.
		self assert: expected = actual
	] ensure: [ 
		GRPlatform current removeSelector: #stringMethod from: self class ]
]

{ #category : 'tests-mop' }
GRPlatformTest >> testCompileUnicodeString [
	| selector expected source |
	selector := #stringMethod.
	expected := String
		with: (Character value: 16r1F1F3)
		with: (Character value: 16r1F1F1).
	source := GRPlatform current asMethodReturningString: expected named: selector.
	[ 
		| actual |
		GRPlatform current compile: source into: self class classified: 'private'.
		actual := self perform: selector.
		self assert: expected = actual
	] ensure: [ 
		GRPlatform current removeSelector: #stringMethod from: self class ]
]

{ #category : 'tests' }
GRPlatformTest >> testConvertToSmalltalkNewlines [
	| expected |
	expected := 'a' , GRPlatform current newline , 'b'.
	self assert: (GRPlatform current convertToSmalltalkNewlines: nil) isNil.
	self assert: (GRPlatform current convertToSmalltalkNewlines: '') = ''.
	self assert: (GRPlatform current convertToSmalltalkNewlines: 'abc') = 'abc'.
	self 
		assert: (GRPlatform current convertToSmalltalkNewlines: 'a' , (String with: Character cr with: Character lf) , 'b')
			= expected
		description: 'Multics, Unix and Unix-like systems (GNU/Linux, AIX, Xenix, Mac OS X, FreeBSD, etc.), BeOS, Amiga, RISC OS, and others'.
	self
		assert: (GRPlatform current convertToSmalltalkNewlines: 'a' , (String with: Character lf) , 'b')
			= expected
		description: 'DEC RT-11 and most other early non-Unix, non-IBM OSes, CP/M, MP/M, MS-DOS, OS/2, Microsoft Windows, Symbian OS'.
	self 
		assert: (GRPlatform current convertToSmalltalkNewlines: 'a' , (String with: Character cr) , 'b')
			= expected
		description: 'Commodore 8-bit machines, TRS-80, Apple II family, Mac OS up to version 9 and OS-9'
]

{ #category : 'tests' }
GRPlatformTest >> testDateArithmetic [
	| today tomorrow oneDay minusOneDay |
	today := DateAndTime year: 2008 month: 9 day: 13 hour: 14 minute: 32 second: 05 offset: Duration zero.
	tomorrow := DateAndTime year: 2008 month: 9 day: 14 hour: 14 minute: 32 second: 05 offset: Duration zero.
	oneDay := Duration days: 1 hours: 0 minutes: 0 seconds: 0.
	minusOneDay := Duration days: -1 hours: 0 minutes: 0 seconds: 0.
	self assert: tomorrow - today = oneDay.
	self assert: today - tomorrow = minusOneDay.
	self assert: today + oneDay = tomorrow.
	self assert: tomorrow - oneDay = today.
	self assert: tomorrow + minusOneDay = today.
	self assert: today - minusOneDay = tomorrow
]

{ #category : 'tests' }
GRPlatformTest >> testDaysInMonthForYear [
	(1 to: 12) with: #(31 28 31 30 31 30 31 31 30 31 30 31) do: [ :month :days |
		self assert: days = (Date daysInMonth: (Date nameOfMonth: month) forYear: 2007) ]
]

{ #category : 'tests' }
GRPlatformTest >> testDigitValue [
	'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ' 
		with: (0 to: 35)
		do: [ :each :expected | self assert: each digitValue = expected ]
]

{ #category : 'tests' }
GRPlatformTest >> testEmptyOrNil [
	self assert: '' isEmptyOrNil.
	self assert: nil isEmptyOrNil.
	self assert: Array new isEmptyOrNil.
	self deny: 'Timberwolf' isEmptyOrNil
]

{ #category : 'tests-files' }
GRPlatformTest >> testFileExists [
	| theFileName |
	self 
		writeToFile: 'test' 
		withFileNameDo:[ :fileName |
			self assert: (GRPlatform current fileExists: fileName).
			theFileName := fileName ].
	self deny: (GRPlatform current fileExists: theFileName)
]

{ #category : 'tests-encoding' }
GRPlatformTest >> testGreaseAsByteArray [
	self assert: 1024 greaseAsByteArray equals: #[4 0].
	self assert: (SmallInteger maxVal + 10) greaseAsByteArray equals: #[16 0 0 0 0 0 0 9].
	self assert: (SmallInteger minVal - 10) greaseAsByteArray equals: #[16 0 0 0 0 0 0 10].
	self assert: #[1 2 3] greaseAsByteArray equals: #[1 2 3].
	self assert: '123' greaseAsByteArray equals: #[49 50 51]
]

{ #category : 'tests-encoding' }
GRPlatformTest >> testGreaseByteAt [
	self assert: (1024 greaseByteAt: 1) equals: 0.
	self assert: (1024 greaseByteAt: 2) equals: 4.
	self assert: ((SmallInteger maxVal + 10) greaseByteAt: 1) equals: 9.
	self assert: ((SmallInteger maxVal + 10) greaseByteAt: 8) equals: 16.
	self assert: ((SmallInteger minVal - 10) greaseByteAt: 1) equals: 10.
	self assert: ((SmallInteger minVal - 10) greaseByteAt: 8) equals: 16
]

{ #category : 'tests-encoding' }
GRPlatformTest >> testGreaseBytesCount [
	self assert: 1024 greaseBytesCount equals: 2.
	self assert: (SmallInteger maxVal + 10) greaseBytesCount equals: 8.
	self assert: (SmallInteger minVal + 10) greaseBytesCount equals: 8
]

{ #category : 'tests' }
GRPlatformTest >> testGreaseIntegerOnCharacterAscii [
	"ASCII (1 byte)"
	self assert: $a greaseInteger = 97.
	self assert: $A greaseInteger = 65
]

{ #category : 'tests' }
GRPlatformTest >> testGreaseIntegerOnCharacterBmp [
	"BMP (3 byte)"
	| euro |
	euro := self decodeUtf8Character: #(226 130 172 ).
	self assert: euro greaseInteger = 8364
]

{ #category : 'tests' }
GRPlatformTest >> testGreaseIntegerOnCharacterLatin1 [
	"Latin-1 (2 byte)"
	| oWithStroke |
	oWithStroke := self decodeUtf8Character: #(195 152 ).
	self assert: oWithStroke greaseInteger = 216
]

{ #category : 'tests' }
GRPlatformTest >> testGreaseIntegerOnCharacterSmp [
	"SMP (4 byte)"
	| manna |
	manna := self decodeUtf8Character: #(240 144 140 188 ).
	self assert: manna greaseInteger = 66364
]

{ #category : 'tests' }
GRPlatformTest >> testGreaseIntegerOnNumber [
	self assert: 2007 greaseInteger = 2007.
	self assert: 2007.0 greaseInteger = 2007.
	self assert: 2007.1 greaseInteger = 2007.
	self assert: 2007.9 greaseInteger = 2007
]

{ #category : 'tests' }
GRPlatformTest >> testGreaseIntegerOnString [
	self assert: '' greaseInteger isNil.
	self assert: 'a' greaseInteger isNil.
	self assert: ' 1' greaseInteger isNil.
	self assert: 'a1' greaseInteger isNil.
	self assert: '-' greaseInteger isNil.
	self assert: '-a' greaseInteger isNil.
	self assert: '0' greaseInteger = 0.
	self assert: '12' greaseInteger = 12.
	self assert: '123' greaseInteger = 123.
	self assert: '123456789' greaseInteger = 123456789.
	self assert: '-0' greaseInteger = 0.
	self assert: '-12' greaseInteger = -12.
	self assert: '-123.4' greaseInteger = -123.
	self assert: '-123456789' greaseInteger = -123456789
]

{ #category : 'tests' }
GRPlatformTest >> testGreaseString [
	self assert: 'Timberwolf' greaseString = 'Timberwolf'.
	self assert: #DireWolf greaseString = 'DireWolf'.
	self deny: #DireWolf greaseString isSymbol.
	self assert: true greaseString = 'true'.
	self assert: 666 greaseString = '666'.
	"make sure we're not immediate"
	self assert: ((2 raisedTo: 64) + 1) greaseString = '18446744073709551617'.
	"make sure we're not immediate"
	self assert: ((2 raisedTo: 64) + 1) negated greaseString = '-18446744073709551617'.
	self assert: $A greaseString = 'A'.
	self assert: nil greaseString = 'nil'.
	[	"Smalltalk/X has constant folding so 1 / 0 will be evaluated at compile time
		resulting in an error when loading the code."
		1 perform: #/ with: 0 ] 
		on: ZeroDivide
		do: [ :error | self assert: error greaseString isString ].
	self assert: 15.25 greaseString = '15.25'.
	self assert: nil greaseString isString.
	self assert: (4 @ 2) greaseString = '4@2'.
	"#greaseString for a byte array should not do any decoding
	this is in place to catch encoding errors early"
	self assert: #(101 97 ) asByteArray greaseString ~= 'ea'.
	self assert: #(101 97 ) asByteArray greaseString isString.
	self assert: Object new greaseString isString.
	"Printing scaled decimals (https://github.com/SeasideSt/Grease/issues/1)"
	self assert: 1.21s3 greaseString = '1.210'.
	self assert: -1.21s3 greaseString = '-1.210'
]

{ #category : 'tests' }
GRPlatformTest >> testIfNil [
	self assert: (nil ifNil: [ 1 ]) = 1.
	self assert: (1 ifNil: [ 2 ]) = 1
]

{ #category : 'tests' }
GRPlatformTest >> testIfTrueIfFalse [
	self assert: (false ifFalse: [ #false ]) = #false.
	self assert: (false ifTrue: [ #true ]) isNil.
	self assert: (true ifTrue: [ #true ]) = #true.
	self assert: (true ifFalse: [ #false ]) isNil.
	self assert: (true ifTrue: [ #true ] ifFalse: [ #false ]) = #true.
	self assert: (false ifTrue: [ #true ] ifFalse: [ #false ]) = #false.
	self assert: (true ifFalse: [ #false ] ifTrue: [ #true ]) = #true.
	self assert: (false ifFalse: [ #false ] ifTrue: [ #true ]) = #false
]

{ #category : 'tests' }
GRPlatformTest >> testIsCharacter [
	self deny: 7 isCharacter.
	self assert: $7 isCharacter
]

{ #category : 'tests' }
GRPlatformTest >> testIsCollection [
	self deny: Object new isCollection
]

{ #category : 'tests' }
GRPlatformTest >> testIsKeyword [
	self deny: #isKeyword isKeyword.
	self deny: #+ isKeyword.
	self assert: #isKeyword: isKeyword.
	self assert: #isKeyword:isKeyword: isKeyword
]

{ #category : 'tests' }
GRPlatformTest >> testIsUnary [
	self assert: #isUnary isUnary.
	self deny: #+ isUnary.
	self deny: #isUnary: isUnary.
	self deny: #isUnary:isUnary: isUnary
]

{ #category : 'tests' }
GRPlatformTest >> testLabel [
	self assert: (self platform label isKindOf: String).
	self deny: self platform label isEmpty
]

{ #category : 'tests-files' }
GRPlatformTest >> testNewTemporaryFile [

	| temporaryFile1 temporaryFile2 |
	[
		temporaryFile1 := GRPlatform current newTemporaryFile.
		temporaryFile2 := GRPlatform current newTemporaryFile.
		GRPlatform current
			writeFileStreamOn: temporaryFile1
			do: [ :str | str nextPutAll: 'test temporary' ]
			binary: false.
		GRPlatform current
			writeFileStreamOn: temporaryFile2
			do: [ :str | str nextPutAll: #[116 101 115 116 32 116 101 109 112 111 114 97 114 121] ]
			binary: true.
		self assert: (GRPlatform current fileExists: temporaryFile1).
		self deny: (GRPlatform current localNameOf: temporaryFile1) equals: (GRPlatform current localNameOf: temporaryFile2)
	] ensure: [ GRPlatform current deleteFile: temporaryFile1. GRPlatform current deleteFile: temporaryFile2  ].
	self deny: (GRPlatform current fileExists: temporaryFile1).
	self deny: (GRPlatform current fileExists: temporaryFile2)
]

{ #category : 'tests-files' }
GRPlatformTest >> testNewTemporaryFileNamed [

	| temporaryFile fileName |
	fileName := 'GRPlatformTestTemporaryFile'.
	[
		temporaryFile := GRPlatform current newTemporaryFileNamed: fileName.
		GRPlatform current
			writeFileStreamOn: temporaryFile
			do: [ :str | str nextPutAll: 'test temporary' ]
			binary: false.
		self assert: (GRPlatform current fileExists: temporaryFile).
		self should: [ GRPlatform current newTemporaryFileNamed: fileName ] raise: GRError.
	] ensure: [ GRPlatform current deleteFile: temporaryFile ].
	self deny: (GRPlatform current fileExists: temporaryFile).
	
]

{ #category : 'tests' }
GRPlatformTest >> testNewline [
	self assert: GRPlatform current newline isString.
	self deny: GRPlatform current newline isEmpty
]

{ #category : 'tests' }
GRPlatformTest >> testNumArgs [
	self assert: #not numArgs isZero.
	self assert: #+ numArgs = 1.
	self assert: #and: numArgs = 1.
	self assert: #value:value: numArgs = 2
]

{ #category : 'tests' }
GRPlatformTest >> testPathSeparator [
	self assert: GRPlatform current pathSeparator isString
]

{ #category : 'tests' }
GRPlatformTest >> testPrintStringLimitedTo [

	| longString shortString |
	longString := String streamContents: [ :stream |
		1 to: 1000 do: [ :i | stream nextPutAll: i printString ] ].
	"Squeak implementation adds 9 characters to limited string and VA Smalltalk adds 10, so we can't do an exact count."
	self assert: longString printString size > 65.
	shortString := longString printStringLimitedTo: 50.
	self assert: shortString size < 65
]

{ #category : 'tests-streams' }
GRPlatformTest >> testRandomGenerator [
	| generator collection |
	generator := self platform newRandom.
	self should: [ generator nextInt: 0 ] raise: Error.
	self assert: (generator nextInt: 1) = 1.
	collection := (1 to: 200) collect: [ :ea | generator nextInt: 2 ].
	self assert: (collection includes: 1).
	self assert: (collection includes: 2).
	self assert: collection asSet size = 2.

	collection := 1 to: 5.
	self assert: (collection includes: (generator randomFrom: collection)).
	collection := -1.5 to: 3.5.
	self assert: (collection includes: (generator randomFrom: collection)).
	collection := #(1 2 3 4 5).
	self assert: (collection includes: (generator randomFrom: collection)).
	collection := #(1 2 3 4 5) asSet.
	self assert: (collection includes: (generator randomFrom: collection))
]

{ #category : 'tests-streams' }
GRPlatformTest >> testReadStreamAtEnd [
	"ANSI 5.9.2.1"
	
	| stream |
	stream := '' readStream.
	self assert: stream atEnd.

	stream := 'a' readStream.
	self deny: stream atEnd
]

{ #category : 'tests-streams' }
GRPlatformTest >> testReadStreamContents [
	"ANSI 5.9.3.1"
	
	| stream |
	stream := 'abc' readStream.
	self assert: stream contents = 'abc'.
	stream next: 2.
	self assert: stream contents = 'abc'
]

{ #category : 'tests-streams' }
GRPlatformTest >> testReadStreamNegativeSkip [
	"ANSI does not mention negative values being used with #skip: but we
	believe they work consistently. If not, we need to update our coding
	conventions to make sure we never do this."
	
	| stream position |
	stream := 'abcd' readStream.
	stream next; next.
	position := stream position.
	self assert: (stream peek) = $c.
	stream skip: -1.
	self assert: stream position = (position - 1).
	self assert: (stream peek) = $b
]

{ #category : 'tests-streams' }
GRPlatformTest >> testReadStreamNext [
	"ANSI 5.9.2.3"
	
	| stream |
	stream := 'abcd' readStream.
	self assert: stream next = $a.
	self assert: (stream next: 0) = ''.
	self assert: (stream next: 1) = 'b'.
	self assert: (stream next: 2) = 'cd'
]

{ #category : 'tests-streams' }
GRPlatformTest >> testReadStreamPeek [
	"ANSI 5.9.2.7"
	
	| stream |
	stream := 'abcd' readStream.
	self assert: stream peek = $a.
	
	stream := '' readStream.
	self assert: stream peek isNil
]

{ #category : 'tests-streams' }
GRPlatformTest >> testReadStreamPosition [
	"ANSI 5.9.1.4 and 5.9.1.5"
	
	| stream |
	stream := 'abc' readStream.
	self assert: stream position = 0.
	stream next.
	self assert: stream position = 1.
	stream next.
	self assert: stream position = 2.
	stream next.
	self assert: stream position = 3.
	
	stream position: 1.
	self assert: stream position = 1.
	self assert: stream next = $b.
	stream position: 0.
	self assert: stream position = 0.
	self assert: stream next = $a.
	stream position: 3.
	self assert: stream atEnd
]

{ #category : 'tests-streams' }
GRPlatformTest >> testReadStreamReset [
	"ANSI 5.9.1.6"
	
	| stream |
	stream := 'abc' readStream.
	stream next: 2.
	stream reset.
	self assert: stream next = $a
]

{ #category : 'tests-streams-seaside' }
GRPlatformTest >> testReadStreamSeasideUpToAll [
	| stream string1 string2 |
	stream := 'abc12def' readStream.
	string1 := stream greaseUpToAll: '12'.
	string2 := stream greaseUpToAll: '12'.
	self assert: string1 = 'abc'.
	self assert: string2 = 'def'.
	self assert: stream atEnd
]

{ #category : 'tests-streams' }
GRPlatformTest >> testReadStreamSkip [
	"ANSI 5.9.2.9"
	
	| stream |
	stream := 'abcd' readStream.
	self assert: (stream skip: 2; peek) = $c
]

{ #category : 'tests-streams' }
GRPlatformTest >> testReadStreamUpTo [
	"ANSI 5.9.2.11"
	
	| stream |
	stream := 'abcd' readStream.
	self assert: (stream upTo: $c) = 'ab'.
	self assert: stream next = $d.
	
	stream := 'abcd' readStream.
	self assert: (stream upTo: $x) = 'abcd'.
	self assert: stream atEnd
]

{ #category : 'tests-streams' }
GRPlatformTest >> testReadStreamUpToEnd [
	"Not defined by ANSI."
	
	| stream |
	stream := 'abcd' readStream.
	self assert: stream upToEnd = 'abcd'.
	self assert: stream atEnd.
	self assert: stream upToEnd = ''.
	self assert: stream atEnd.
	
	stream := 'abcd' readStream.
	stream upTo: $b.
	self assert: stream upToEnd = 'cd'.
	self assert: stream atEnd
]

{ #category : 'tests-streams' }
GRPlatformTest >> testReadWriteStreamAtEnd [
	"ANSI 5.9.2.1"
	| stream |
	stream := GRPlatform current readWriteCharacterStream.
	self assert: stream atEnd.
	stream
		nextPut: $a;
		reset.
	self deny: stream atEnd
]

{ #category : 'tests-streams' }
GRPlatformTest >> testReadWriteStreamContents [
	"ANSI 5.9.3.1"
	| stream |
	stream := GRPlatform current readWriteCharacterStream.
	stream
		nextPutAll: 'abc';
		reset.
	self assert: stream contents = 'abc'.
	stream next: 2.
	self assert: stream contents = 'abc'.
	stream := GRPlatform current readWriteByteStream.
	stream
		nextPutAll: 'abc' asByteArray;
		reset.
	self assert: stream contents = 'abc' asByteArray.
	stream next: 2.
	self assert: stream contents = 'abc' asByteArray
]

{ #category : 'tests-streams' }
GRPlatformTest >> testReadWriteStreamNegativeSkip [
	"ANSI does not mention negative values being used with #skip: but we
	believe they work consistently. If not, we need to update our coding
	conventions to make sure we never do this."
	| stream position |
	stream := GRPlatform current readWriteCharacterStream.
	stream
		nextPutAll: 'abcd';
		reset.
	stream
		next;
		next.
	position := stream position.
	self assert: stream peek = $c.
	stream skip: -1.
	self assert: stream position = (position - 1).
	self assert: stream peek = $b.
	stream := GRPlatform current readWriteByteStream.
	stream
		nextPutAll: 'abcd' asByteArray;
		reset.
	stream
		next;
		next.
	position := stream position.
	self assert: stream peek = 99.
	stream skip: -1.
	self assert: stream position = (position - 1).
	self assert: stream peek = 98
]

{ #category : 'tests-streams' }
GRPlatformTest >> testReadWriteStreamNext [
	"ANSI 5.9.2.3"
	| stream |
	stream := GRPlatform current readWriteCharacterStream.
	stream
		nextPutAll: 'abcd';
		reset.
	self assert: stream next = $a.
	self assert: (stream next: 0) = ''.
	self assert: (stream next: 1) = 'b'.
	self assert: (stream next: 2) = 'cd'.
	stream := GRPlatform current readWriteByteStream.
	stream
		nextPutAll: 'abcd' asByteArray;
		reset.
	self assert: stream next = 97.
	self assert: (stream next: 0) = '' asByteArray.
	self assert: (stream next: 1) = 'b' asByteArray.
	self assert: (stream next: 2) = 'cd' asByteArray
]

{ #category : 'tests-streams' }
GRPlatformTest >> testReadWriteStreamNextPut [
	"ANSI 5.9.4.3"
	| stream |
	stream := GRPlatform current readWriteCharacterStream.
	stream nextPut: $a.
	self assert: stream contents = 'a'.
	stream := GRPlatform current readWriteByteStream.
	stream nextPut: 97.
	self assert: stream contents = 'a' asByteArray
]

{ #category : 'tests-streams' }
GRPlatformTest >> testReadWriteStreamNextPutAll [
	"ANSI 5.9.4.4"
	| stream |
	stream := GRPlatform current readWriteCharacterStream.
	stream nextPutAll: 'abc'.
	self assert: stream contents = 'abc'.
	stream := GRPlatform current readWriteCharacterStream.
	stream nextPutAll: #($a $b $c).
	self assert: stream contents = 'abc'.
	stream := GRPlatform current readWriteByteStream.
	stream nextPutAll: #(97 98 99 ) asByteArray.
	self assert: stream contents = 'abc' asByteArray
]

{ #category : 'tests-streams' }
GRPlatformTest >> testReadWriteStreamPeek [
	"ANSI 5.9.2.7"
	| stream |
	stream := GRPlatform current readWriteCharacterStream.
	self assert: stream peek isNil.
	stream := GRPlatform current readWriteCharacterStream.
	stream
		nextPutAll: 'abcd';
		reset.
	self assert: stream peek = $a.
	stream := GRPlatform current readWriteByteStream.
	stream
		nextPutAll: 'abcd' asByteArray;
		reset.
	self assert: stream peek = 97
]

{ #category : 'tests-streams' }
GRPlatformTest >> testReadWriteStreamPosition [
	"ANSI 5.9.1.4 and 5.9.1.5"
	| stream |
	stream := GRPlatform current readWriteCharacterStream.
	stream
		nextPutAll: 'abc';
		reset.
	self assert: stream position = 0.
	stream next.
	self assert: stream position = 1.
	stream next.
	self assert: stream position = 2.
	stream next.
	self assert: stream position = 3.
	stream position: 1.
	self assert: stream position = 1.
	self assert: stream next = $b.
	stream position: 0.
	self assert: stream position = 0.
	self assert: stream next = $a.
	stream position: 3.
	self assert: stream atEnd.
	stream := GRPlatform current readWriteByteStream.
	stream
		nextPutAll: 'abc' asByteArray;
		reset.
	self assert: stream position = 0.
	stream next.
	self assert: stream position = 1.
	stream next.
	self assert: stream position = 2.
	stream next.
	self assert: stream position = 3.
	stream position: 1.
	self assert: stream position = 1.
	self assert: stream next = 98.
	stream position: 0.
	self assert: stream position = 0.
	self assert: stream next = 97.
	stream position: 3.
	self assert: stream atEnd
]

{ #category : 'tests-streams' }
GRPlatformTest >> testReadWriteStreamReset [
	"ANSI 5.9.1.6"
	| stream |
	stream := GRPlatform current readWriteCharacterStream.
	stream
		nextPutAll: 'abc';
		reset.
	stream next: 2.
	stream reset.
	self assert: stream next = $a.
	stream := GRPlatform current readWriteCharacterStream.
	stream
		nextPutAll: 'abc';
		reset.
	stream nextPutAll: 'def'.
	self assert: stream contents = 'def'.
	stream := GRPlatform current readWriteByteStream.
	stream
		nextPutAll: 'abc' asByteArray;
		reset.
	stream next: 2.
	stream reset.
	self assert: stream next = 97
]

{ #category : 'tests-streams' }
GRPlatformTest >> testReadWriteStreamSkip [
	"ANSI 5.9.2.9"
	| stream |
	stream := GRPlatform current readWriteCharacterStream.
	stream
		nextPutAll: 'abcd';
		reset.
	self assert: (stream
			skip: 2;
			peek) = $c.
	stream := GRPlatform current readWriteByteStream.
	stream
		nextPutAll: 'abcd' asByteArray;
		reset.
	self assert: (stream
			skip: 2;
			peek) = 99
]

{ #category : 'tests-streams' }
GRPlatformTest >> testReadWriteStreamTab [
	"ANSI 5.9.4.6"
	| stream |
	stream := GRPlatform current readWriteCharacterStream.
	stream tab.
	self assert: stream contents first = Character tab
]

{ #category : 'tests-streams' }
GRPlatformTest >> testReadWriteStreamUpTo [
	"ANSI 5.9.2.11"
	| stream |
	stream := GRPlatform current readWriteCharacterStream.
	stream
		nextPutAll: 'abcd';
		reset.
	self assert: (stream upTo: $c) = 'ab'.
	self assert: stream next = $d.
	stream := GRPlatform current readWriteCharacterStream.
	stream
		nextPutAll: 'abcd';
		reset.
	self assert: (stream upTo: $x) = 'abcd'.
	self assert: stream atEnd.
	stream := GRPlatform current readWriteByteStream.
	stream
		nextPutAll: 'abcd' asByteArray;
		reset.
	self assert: (stream upTo: 99) = #(97 98 ) asByteArray.
	self assert: stream next = 100.
	stream := GRPlatform current readWriteByteStream.
	stream
		nextPutAll: 'abcd' asByteArray;
		reset.
	self assert: (stream upTo: 120) = #(97 98 99 100 ) asByteArray.
	self assert: stream atEnd
]

{ #category : 'tests-streams' }
GRPlatformTest >> testReadWriteStreamUpToEnd [
	"Not defined by ANSI."
	| stream |
	stream := GRPlatform current readWriteCharacterStream.
	stream
		nextPutAll: 'abcd';
		reset.
	self assert: stream upToEnd = 'abcd'.
	self assert: stream atEnd.
	self assert: stream upToEnd = ''.
	self assert: stream atEnd.
	stream reset.
	stream upTo: $b.
	self assert: stream upToEnd = 'cd'.
	self assert: stream atEnd.
	stream := GRPlatform current readWriteByteStream.
	stream
		nextPutAll: 'abcd' asByteArray;
		reset.
	self assert: stream upToEnd = #(97 98 99 100 ) asByteArray.
	self assert: stream atEnd.
	self assert: stream upToEnd = #() asByteArray.
	self assert: stream atEnd.
	stream reset.
	stream upTo: 98.
	self assert: stream upToEnd = #(99 100 ) asByteArray.
	self assert: stream atEnd
]

{ #category : 'tests' }
GRPlatformTest >> testSeconds [
	self assert: Time now seconds isInteger
]

{ #category : 'tests' }
GRPlatformTest >> testSecureHashFor [
	"Make sure the platform class provides a #secureHashFor: method. The method is called by Seaside when hashing passwords. 
	The Pharo implementation returns a SHA-1 hash but another equivalent hash method could also be used."
	
	| a b c d invalidUtf8 e f |
	a := self platform secureHashFor: 'foobar'.
	b := self platform secureHashFor: 'foobar'.
	self assert: a equals: b.

	c := self platform secureHashFor: #[102 111 111 98 97 114].
	d := self platform secureHashFor: #[102 111 111 98 97 114].
	self assert: c equals: d.
	
	"The following ensures any byte array can be used (and not only the onces containing valid utf8)"
	invalidUtf8 := #[160 161].
	e := self platform secureHashFor: invalidUtf8.
	f := self platform secureHashFor: invalidUtf8.
	self assert: e equals: f
]

{ #category : 'tests-image' }
GRPlatformTest >> testShutDownList [
	"A smoke test: checks if the test-class can be added and removed to the shutdown list."
	
	[ self platform addToShutDownList: self class ]
		ensure: [  self platform removeFromShutDownList: self class ]
]

{ #category : 'tests-files' }
GRPlatformTest >> testSizeOfFile [
	| theFileName |
	self
		writeToFile: 'test me'
		withFileNameDo:[ :fileName |
			self assert: (GRPlatform current sizeOfFile: fileName) equals: 7.
			theFileName := fileName ].
	self deny: (GRPlatform current fileExists: theFileName)
]

{ #category : 'tests-mop' }
GRPlatformTest >> testSourceCodeStringOf [

	| sourceCodeString |
	sourceCodeString := GRPlatform current sourceCodeStringOf: GRPlatform >> #sourceCodeStringOf:.
	self
		assert: sourceCodeString
		equals: 'sourceCodeStringOf: aCompiledMethod
	"Return a String with the source code for a compiled method."

	self subclassResponsibility'
]

{ #category : 'tests' }
GRPlatformTest >> testStackDepth [
	| stackDepth someBlock |
	stackDepth := self platform stackDepth.
	self assert: stackDepth isInteger.
	self assert: stackDepth > 0.
	someBlock := [ self assert: self platform stackDepth > stackDepth ].
	someBlock value.
	self assert: stackDepth = self platform stackDepth
]

{ #category : 'tests-image' }
GRPlatformTest >> testStartUpList [
	"A smoke test: checks if the test-class can be added and removed to the startup list."
	
	[  self platform addToStartUpList: self class ]
		ensure: [  self platform removeFromStartUpList: self class ]
]

{ #category : 'tests' }
GRPlatformTest >> testSymbolAsMutator [
	"test for:
	Symbol >> #asMutator
	^ (self copyWith: $:) asSymbol"
	self assert: #name greaseAsMutator = #name:
]

{ #category : 'tests-processes' }
GRPlatformTest >> testTerminate [
	| ensureRun ifCurtailedRun semaphore1 semaphore2 semaphore3 semaphore4 process |
	ensureRun := false.
	ifCurtailedRun := false.
	semaphore1 := self platform semaphoreClass new.
	semaphore2 := self platform semaphoreClass new.
	semaphore3 := self platform semaphoreClass new.
	semaphore4 := self platform semaphoreClass new.
	process := [
		[ [ semaphore1 signal. semaphore2 wait ]
			ensure: [ ensureRun := true. semaphore3 signal ] ]
			ifCurtailed: [ ifCurtailedRun := true. semaphore4 signal ] ] newProcess.
	self deny: (self platform isProcessTerminated: process).
	process resume.
	semaphore1 wait.
	self deny: (self platform isProcessTerminated: process).
	self platform terminateProcess: process.
	semaphore3 wait.
	self assert: ensureRun.
	semaphore4 wait.
	self assert: ifCurtailedRun.
	self assert: (self platform isProcessTerminated: process)
]

{ #category : 'tests' }
GRPlatformTest >> testThisContext [
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
]

{ #category : 'tests' }
GRPlatformTest >> testTotalSeconds [
	"Answer the total seconds since the Squeak epoch: 1 January 1901."

	| seconds |
	seconds := Time totalSeconds.
	self assert: seconds isInteger.
	self assert: seconds > 3421645167
]

{ #category : 'tests' }
GRPlatformTest >> testVersion [
	self assert: (self platform version isKindOf: GRVersion).
	self assert: (self platform versionString isKindOf: String).
	self deny: self platform versionString isEmpty
]

{ #category : 'tests-streams' }
GRPlatformTest >> testWriteStreamContents [
	| stream |
	stream := GRPlatform current writeCharacterStreamOn: String new.
	self assert: stream contents = ''.
	stream
		nextPutAll: 'abcdef'.
	self assert: stream contents = 'abcdef'.
	stream
		reset;
		nextPutAll: 'gh'.
	self assert: stream contents = 'gh'
]

{ #category : 'tests-streams' }
GRPlatformTest >> testWriteStreamCrLf [
	| stream |
	stream := WriteStream on: String new.
	stream crlf.
	self assert: stream contents first codePoint = 13.
	self assert: stream contents second codePoint = 10
]

{ #category : 'tests-streams' }
GRPlatformTest >> testWriteStreamNextPut [
	"ANSI 5.9.4.3"
	
	| stream |
	stream := WriteStream on: String new.
	stream nextPut: $a.
	self assert: stream contents = 'a'
]

{ #category : 'tests-streams' }
GRPlatformTest >> testWriteStreamNextPutAll [
	"ANSI 5.9.4.4"
	
	| stream |
	stream := WriteStream on: String new.
	stream nextPutAll: 'abc'.
	self assert: stream contents = 'abc'.
	
	stream := WriteStream on: String new.
	stream nextPutAll: #($a $b $c).
	self assert: stream contents = 'abc'
]

{ #category : 'tests-streams' }
GRPlatformTest >> testWriteStreamPosition [
	| stream |
	stream := GRPlatform current writeCharacterStreamOn: String new.
	self assert: stream position = 0.
	stream nextPutAll: 'abc'.
	self assert: stream position = 3.
	stream reset.
	self assert: stream position = 0
]

{ #category : 'tests-streams' }
GRPlatformTest >> testWriteStreamReset [
	"ANSI 5.9.1.6"
	
	| stream |
	stream := WriteStream on: String new.
	stream nextPutAll: 'abc'.
	stream reset.
	stream nextPutAll: 'def'.
	self assert: stream contents = 'def'
]

{ #category : 'tests-streams' }
GRPlatformTest >> testWriteStreamSpace [
	"ANSI 5.9.4.5"
	
	| stream |
	stream := WriteStream on: String new.
	stream space.
	self assert: stream contents first = Character space
]

{ #category : 'tests-streams' }
GRPlatformTest >> testWriteStreamTab [
	"ANSI 5.9.4.6"
	
	| stream |
	stream := WriteStream on: String new.
	stream tab.
	self assert: stream contents first = Character tab
]

{ #category : 'tests-files' }
GRPlatformTest >> testWriteToFileInFolder [

	| bytes text |
	bytes := ByteArray new.
	self
		writeToFile: bytes 
		withFileNameDo:[ :fileName |
			self assert: (GRPlatform current contentsOfFile: fileName binary: true) equals: bytes ].

	bytes := #[80 104 39 110 103 108 117 105 32 109 103 108 119 39 110 97 102 104 32 67 116 104 117 108 104 117 32 82 39 108 121 101 104 32 119 103 97 104 39 110 97 103 108 32 102 104 116 97 103 110].
	self 
		writeToFile: bytes 
		withFileNameDo:[ :fileName |
			self assert:(GRPlatform current contentsOfFile: fileName binary: true) equals: bytes ].

	text := String new.
	self 
		writeToFile: text 
		withFileNameDo:[ :fileName |
			self assert: (GRPlatform current contentsOfFile: fileName binary: false) equals: text ].
		
	text := 'Ph''nglui mglw''nafh Cthulhu R''lyeh wgah''nagl fhtagn'.
	self 
		writeToFile: text 
		withFileNameDo:[ :fileName |
			self assert: (GRPlatform current contentsOfFile: fileName binary: false) equals: text ] 
]
