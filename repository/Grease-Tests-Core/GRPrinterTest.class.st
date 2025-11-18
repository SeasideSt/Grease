Class {
	#name : 'GRPrinterTest',
	#superclass : 'TestCase',
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'tests-utilites' }
GRPrinterTest >> separate: aString left: aCharacter [
	| converter |
	converter := GRNumberPrinter new.
	^ String streamContents: [ :stream |
		converter 
			separate: aString
			left: aCharacter
			on: stream ]
]

{ #category : 'tests' }
GRPrinterTest >> testComposedPrinter [
	| converter |
	converter := GRSequentialPrinter new , 'CHF ' , GRNumberPrinter new.
	self assert: (converter print: 1234) = 'CHF 1234'.
	self assert: (converter print: -1234) = 'CHF 1234'.
	converter := GRSignPrinter new , GRNumberPrinter new , '%'.
	self assert: (converter print: 1234) = '1234%'.
	self assert: (converter print: -1234) = '-1234%'
]

{ #category : 'tests-timestamp' }
GRPrinterTest >> testCookieTimestamp [
	| printer date |
	printer := GRPrinter cookieTimestamp.
	date := DateAndTime 
		year: 2008
		month: 8
		day: 1
		hour: 9
		minute: 4
		second: 4
		offset: (Duration 
				days: 0
				hours: 0
				minutes: 0
				seconds: 0).
	self assert: (printer print: date) = 'Fri, 01-Aug-2008 09:04:04 GMT'
]

{ #category : 'tests-utilites' }
GRPrinterTest >> testDigitsOf [
	| converter |
	converter := GRNumberPrinter new.
	self assert: (converter 
			digitsOf: 0.0
			base: 10) = '0'.
	self assert: (converter 
			digitsOf: 1.0
			base: 10) = '1'.
	self assert: (converter 
			digitsOf: -1.0
			base: 10) = '1'.
	self assert: (converter 
			digitsOf: -1234567890
			base: 10) = '1234567890'.
	self assert: (converter 
			digitsOf: 1234567890
			base: 10) = '1234567890'.
	self assert: (converter 
			digitsOf: -9876543210
			base: 10) = '9876543210'.
	self assert: (converter 
			digitsOf: 9876543210
			base: 10) = '9876543210'
]

{ #category : 'tests-utilites' }
GRPrinterTest >> testDigitsOfBase [
	| converter |
	converter := GRNumberPrinter new.
	self assert: (converter 
			digitsOf: 1234
			base: 2) = '10011010010'.
	self assert: (converter 
			digitsOf: 1234
			base: 3) = '1200201'.
	self assert: (converter 
			digitsOf: 1234
			base: 4) = '103102'.
	self assert: (converter 
			digitsOf: 1234
			base: 5) = '14414'.
	self assert: (converter 
			digitsOf: 1234
			base: 6) = '5414'.
	self assert: (converter 
			digitsOf: 1234
			base: 7) = '3412'.
	self assert: (converter 
			digitsOf: 1234
			base: 8) = '2322'.
	self assert: (converter 
			digitsOf: 1234
			base: 9) = '1621'.
	self assert: (converter 
			digitsOf: 1234
			base: 10) = '1234'.
	self assert: (converter 
			digitsOf: 1234
			base: 11) = 'a22'.
	self assert: (converter 
			digitsOf: 1234
			base: 12) = '86a'.
	self assert: (converter 
			digitsOf: 1234
			base: 13) = '73c'.
	self assert: (converter 
			digitsOf: 1234
			base: 14) = '642'.
	self assert: (converter 
			digitsOf: 1234
			base: 15) = '574'.
	self assert: (converter 
			digitsOf: 1234
			base: 16) = '4d2'
]

{ #category : 'tests' }
GRPrinterTest >> testFileSizePrinterBinary [
	| converter |
	converter := GRPrinter binaryFileSize.
	self assert: (converter print: 1) = '1 byte'.
	self assert: (converter print: 2) = '2 bytes'.
	self assert: (converter print: 30) = '30 bytes'.
	self assert: (converter print: 500) = '500 bytes'.
	self assert: (converter print: 6000) = '5.9 KiB'.
	self assert: (converter print: 70000) = '68.4 KiB'.
	self assert: (converter print: 800000) = '781.3 KiB'.
	self assert: (converter print: 9000000) = '8.6 MiB'.
	self assert: (converter print: 10000000) = '9.5 MiB'.
	self assert: (converter print: 200000000) = '190.7 MiB'.
	self assert: (converter print: 3000000000) = '2.8 GiB'.
	self assert: (converter print: 40000000000) = '37.3 GiB'
]

{ #category : 'tests' }
GRPrinterTest >> testFileSizePrinterDecimal [
	| converter |
	converter := GRPrinter decimalFileSize.
	self assert: (converter print: 1) = '1 byte'.
	self assert: (converter print: 2) = '2 bytes'.
	self assert: (converter print: 30) = '30 bytes'.
	self assert: (converter print: 500) = '500 bytes'.
	self assert: (converter print: 6000) = '6.0 kB'.
	self assert: (converter print: 70000) = '70.0 kB'.
	self assert: (converter print: 800000) = '800.0 kB'.
	self assert: (converter print: 9000000) = '9.0 MB'.
	self assert: (converter print: 10000000) = '10.0 MB'.
	self assert: (converter print: 200000000) = '200.0 MB'.
	self assert: (converter print: 3000000000) = '3.0 GB'.
	self assert: (converter print: 40000000000) = '40.0 GB'
]

{ #category : 'tests' }
GRPrinterTest >> testFloatPrinter [
	| converter |
	converter := GRNumberPrinter new precision: 2.
	self assert: (converter print: 1.009) = '1.01'.
	self assert: (converter print: 1.01) = '1.01'.
	self assert: (converter print: 1.019) = '1.02'.
	self assert: (converter print: 1.25) = '1.25'.
	self assert: (converter print: 1.254) = '1.25'.
	self assert: (converter print: 1.256) = '1.26'.
	self assert: (converter print: 1.009) = '1.01'.
	self assert: (converter print: 0.9) = '0.90'.
	self assert: (converter print: 0.99) = '0.99'.
	self assert: (converter print: 0.999) = '1.00'.
	self assert: (converter print: 0.9999) = '1.00'.
	self assert: (converter print: -0.9) = '0.90'.
	self assert: (converter print: -0.99) = '0.99'.
	self assert: (converter print: -0.999) = '1.00'.
	self assert: (converter print: -0.9999) = '1.00'
]

{ #category : 'tests' }
GRPrinterTest >> testFloatPrinterInfinity [
	| converter |
	converter := GRNumberPrinter new.
	self assert: (converter print: Float infinity) = 'Infinite'.
	self assert: (converter print: Float infinity negated) = 'Infinite'.
	converter infinite: 'very huge'.
	self assert: (converter print: Float infinity) = 'very huge'.
	self assert: (converter print: Float infinity negated) = 'very huge'
]

{ #category : 'tests' }
GRPrinterTest >> testFloatPrinterNaN [
	| converter |
	converter := GRNumberPrinter new.
	self assert: (converter print: Float nan) = 'NaN'.
	converter nan: 'Not A Number'.
	self assert: (converter print: Float nan) = 'Not A Number'
]

{ #category : 'tests' }
GRPrinterTest >> testFloatPrinterPadding [
	| converter |
	converter := GRNumberPrinter new.
	converter digits: 3.
	self assert: (converter print: 1) = '  1'.
	self assert: (converter print: 12) = ' 12'.
	self assert: (converter print: 123) = '123'.
	self assert: (converter print: 1234) = '1234'.
	converter padding: $*.
	self assert: (converter print: 1) = '**1'.
	self assert: (converter print: 12) = '*12'.
	self assert: (converter print: 123) = '123'.
	self assert: (converter print: 1234) = '1234'
]

{ #category : 'tests' }
GRPrinterTest >> testFloatPrinterSeparator [
	| converter |
	converter := GRNumberPrinter new.
	converter
		precision: 2;
		separator: $*.
	self assert: (converter print: 12345.0) = '12*345.00'.
	self assert: (converter print: 0.6789) = '0.68'.
	converter
		precision: 4;
		separator: $!.
	self assert: (converter print: 12345.0) = '12!345.000!0'.
	self assert: (converter print: 0.6789) = '0.678!9'
]

{ #category : 'tests-parts-date' }
GRPrinterTest >> testFullMonthName [
	| printer |
	printer := GRPrinter fullMonthName.
	self assert: (printer print: (Date year: 2000 month: 8 day: 1)) = 'August'.
	self assert: (printer print: (Date year: 2000 month: 11 day: 1)) = 'November'
]

{ #category : 'tests-parts-date' }
GRPrinterTest >> testFullWeekName [
	| printer |
	printer := GRPrinter fullWeekName.
	self assert: (printer print: (Date year: 1980 month: 1 day: 1)) = 'Tuesday'.
	self assert: (printer print: (Date year: 2000 month: 1 day: 1)) = 'Saturday'
]

{ #category : 'tests-timestamp' }
GRPrinterTest >> testHttp [
	| printer date offsetHour |
	offsetHour := 2.
	printer := GRPrinter httpDate.
	date := DateAndTime 
		year: 1994
		month: 11
		day: 6
		hour: 8 + offsetHour
		minute: 49
		second: 37
		offset: (Duration 
				days: 0
				hours: offsetHour
				minutes: 0
				seconds: 0).
	self assert: (printer print: date) = 'Sun, 06 Nov 1994 08:49:37 GMT'
]

{ #category : 'tests' }
GRPrinterTest >> testIntegerPrinter [
	| converter |
	converter := GRNumberPrinter new.
	self assert: (converter print: 1234) = '1234'.
	self assert: (converter print: -1234) = '1234'.
	converter separator: $..
	self assert: (converter print: 1234) = '1.234'.
	self assert: (converter print: 1234567) = '1.234.567'.
	converter
		base: 16;
		separator: nil.
	self assert: (converter print: 1234) = '4d2'.
	self assert: (converter print: 123123) = '1e0f3'.
	converter uppercase.
	self assert: (converter print: 1234) = '4D2'.
	self assert: (converter print: 123123) = '1E0F3'.
	
	
	converter
		base: 10;
		separator: $';
		digits: 6;
		padding: $0.
	self assert: (converter print: 1234) = '001''234'.
	self assert: (converter print: 12345) = '012''345'.
	self assert: (converter print: 123456) = '123''456'.
	self assert: (converter print: 1234567) = '1''234''567'.
	self assert: (converter print: 12345678) = '12''345''678'.
	self assert: (converter print: 123456789) = '123''456''789'.
	self assert: (converter print: 0) = '000''000'
]

{ #category : 'tests-timestamp' }
GRPrinterTest >> testIsoDate [
	| printer |
	printer := GRPrinter isoDate.
	self assert: (printer print: (Date 
				year: 1980
				month: 6
				day: 11)) = '1980-06-11'.
	self assert: (printer print: (Date 
				year: 2003
				month: 12
				day: 1)) = '2003-12-01'.
	self assert: (printer print: (Date 
				year: 800
				month: 12
				day: 24)) = '0800-12-24'
]

{ #category : 'tests-timestamp' }
GRPrinterTest >> testIsoTime [
	| printer |
	printer := GRPrinter isoTime.
	self assert: (printer print: (Time 
				hour: 0
				minute: 0
				second: 0)) = '00:00:00'.
	self assert: (printer print: (Time 
				hour: 1
				minute: 2
				second: 3)) = '01:02:03'.
	self assert: (printer print: (Time 
				hour: 12
				minute: 23
				second: 34)) = '12:23:34'
]

{ #category : 'tests' }
GRPrinterTest >> testOrdinalizePrinter [
	| converter |
	converter := GRNumberPrinter new , GROrdinalizePrinter new.
	self assert: (converter print: 1) = '1st'.
	self assert: (converter print: 2) = '2nd'.
	self assert: (converter print: 3) = '3rd'.
	self assert: (converter print: 4) = '4th'.
	self assert: (converter print: 10) = '10th'.
	self assert: (converter print: 111) = '111th'.
	self assert: (converter print: 212) = '212th'.
	self assert: (converter print: 313) = '313th'.
	self assert: (converter print: 414) = '414th'.
	self assert: (converter print: 20) = '20th'.
	self assert: (converter print: 121) = '121st'.
	self assert: (converter print: 222) = '222nd'.
	self assert: (converter print: 323) = '323rd'.
	self assert: (converter print: 424) = '424th'
]

{ #category : 'tests-utilites' }
GRPrinterTest >> testPadCenter [
	| converter |
	converter := GRPrinter new.
	self assert: (converter 
			pad: ''
			center: $*
			to: 3) = '***'.
	self assert: (converter 
			pad: '1'
			center: $*
			to: 3) = '*1*'.
	self assert: (converter 
			pad: '12'
			center: $*
			to: 3) = '12*'.
	self assert: (converter 
			pad: '123'
			center: $*
			to: 3) = '123'.
	self assert: (converter 
			pad: '1234'
			center: $*
			to: 3) = '1234'
]

{ #category : 'tests-utilites' }
GRPrinterTest >> testPadLeft [
	| converter |
	converter := GRPrinter new.
	self assert: (converter 
			pad: ''
			left: $*
			to: 3) = '***'.
	self assert: (converter 
			pad: '1'
			left: $*
			to: 3) = '**1'.
	self assert: (converter 
			pad: '12'
			left: $*
			to: 3) = '*12'.
	self assert: (converter 
			pad: '123'
			left: $*
			to: 3) = '123'.
	self assert: (converter 
			pad: '1234'
			left: $*
			to: 3) = '1234'
]

{ #category : 'tests-utilites' }
GRPrinterTest >> testPadRight [
	| converter |
	converter := GRPrinter new.
	self assert: (converter 
			pad: ''
			right: $*
			to: 3) = '***'.
	self assert: (converter 
			pad: '1'
			right: $*
			to: 3) = '1**'.
	self assert: (converter 
			pad: '12'
			right: $*
			to: 3) = '12*'.
	self assert: (converter 
			pad: '123'
			right: $*
			to: 3) = '123'.
	self assert: (converter 
			pad: '1234'
			right: $*
			to: 3) = '1234'
]

{ #category : 'tests-parts-date' }
GRPrinterTest >> testPaddedCentury [
	| printer |
	printer := GRPrinter paddedCentury.
	self assert: (printer print: (Date year: 1980 month: 1 day: 1)) = '80'.
	self assert: (printer print: (Date year: 2009 month: 1 day: 1)) = '09'
]

{ #category : 'tests-parts-time' }
GRPrinterTest >> testPaddedHour12 [
	| printer |
	printer := GRPrinter paddedHour12.
	self assert: (printer print: (Time hour: 5 minute: 0 second: 0)) = '05'.
	self assert: (printer print: (Time hour: 10 minute: 0 second: 0)) = '10'.
	self assert: (printer print: (Time hour: 14 minute: 0 second: 0)) = '02'.
	self assert: (printer print: (Time hour: 23 minute: 0 second: 0)) = '11'
]

{ #category : 'tests-timestamp' }
GRPrinterTest >> testRfc822 [
	| printer date |
	printer := GRPrinter rfc822.
	date := DateAndTime 
		year: 2008
		month: 8
		day: 1
		hour: 9
		minute: 4
		second: 4
		offset: (Duration 
				days: 0
				hours: -2
				minutes: 0
				seconds: 0).
	self assert: (printer print: date) = 'Fri, 01 Aug 2008 09:04:04 -0200'.
	date := DateAndTime 
		year: 2008
		month: 8
		day: 31
		hour: 19
		minute: 41
		second: 46
		offset: (Duration 
				days: 0
				hours: 0
				minutes: 30
				seconds: 0).
	self assert: (printer print: date) = 'Sun, 31 Aug 2008 19:41:46 +0030'
]

{ #category : 'tests-timestamp' }
GRPrinterTest >> testRfc822WithTimeZone [
	| printer date |
	printer := GRPrinter rfc822WithTimeZone: 'GMT'.
	date := DateAndTime 
		year: 2008
		month: 8
		day: 1
		hour: 9
		minute: 4
		second: 4
		offset: (Duration 
				days: 0
				hours: 0
				minutes: 0
				seconds: 0).
	self assert: (printer print: date) = 'Fri, 01 Aug 2008 09:04:04 GMT'
]

{ #category : 'tests-utilites' }
GRPrinterTest >> testSeparateLeft [
	self assert: (self 
			separate: ''
			left: $*) = ''.
	self assert: (self 
			separate: '1'
			left: $*) = '1'.
	self assert: (self 
			separate: '12'
			left: $*) = '12'.
	self assert: (self 
			separate: '123'
			left: $*) = '123'.
	self assert: (self 
			separate: '1234'
			left: $*) = '123*4'.
	self assert: (self 
			separate: '12345'
			left: $*) = '123*45'.
	self assert: (self 
			separate: '123456'
			left: $*) = '123*456'.
	self assert: (self 
			separate: '1234567'
			left: $*) = '123*456*7'.
	self assert: (self 
			separate: '12345678'
			left: $*) = '123*456*78'.
	self assert: (self 
			separate: '123456789'
			left: $*) = '123*456*789'
]

{ #category : 'tests-utilites' }
GRPrinterTest >> testSeparateRight [
	| converter |
	converter := GRNumberPrinter new.
	self assert: (converter 
			separate: ''
			right: $*) = ''.
	self assert: (converter 
			separate: '1'
			right: $*) = '1'.
	self assert: (converter 
			separate: '12'
			right: $*) = '12'.
	self assert: (converter 
			separate: '123'
			right: $*) = '123'.
	self assert: (converter 
			separate: '1234'
			right: $*) = '1*234'.
	self assert: (converter 
			separate: '12345'
			right: $*) = '12*345'.
	self assert: (converter 
			separate: '123456'
			right: $*) = '123*456'.
	self assert: (converter 
			separate: '1234567'
			right: $*) = '1*234*567'.
	self assert: (converter 
			separate: '12345678'
			right: $*) = '12*345*678'.
	self assert: (converter 
			separate: '123456789'
			right: $*) = '123*456*789'
]

{ #category : 'tests' }
GRPrinterTest >> testSignPrinter [
	| converter |
	converter := GRSignPrinter new.
	converter
		negativePrinter: $-;
		positivePrinter: $+.
	self assert: (converter print: 12) = '+'.
	self assert: (converter print: -12) = '-'
]

{ #category : 'tests' }
GRPrinterTest >> testStringPrinter [
	| converter |
	converter := GRStringPrinter new.
	self assert: (converter print: 123) = '123'.
	self assert: (converter print: 'foo') = 'foo'.
	self assert: (converter print: true) = 'true'
]

{ #category : 'tests' }
GRPrinterTest >> testStringPrinterLength [
	| converter |
	converter := GRStringPrinter new.
	self assert: (converter print: 'foo') = 'foo'.
	converter length: 3.
	self assert: (converter print: 'foo') = 'foo'.
	converter length: 1.
	self assert: (converter print: 'foo') = 'f'
]

{ #category : 'tests' }
GRPrinterTest >> testStringPrinterPad [
	| converter |
	converter := GRStringPrinter new.
	converter
		character: $*;
		length: 5.
	converter padLeft.
	self assert: (converter print: 'foo') = '**foo'.
	converter padRight.
	self assert: (converter print: 'foo') = 'foo**'.
	converter padCenter.
	self assert: (converter print: 'foo') = '*foo*'
]

{ #category : 'tests' }
GRPrinterTest >> testStringPrinterTrim [
	| converter |
	converter := GRStringPrinter new.
	self assert: (converter print: ' foo ') = ' foo '.
	converter trimLeft.
	self assert: (converter print: ' foo ') = 'foo '.
	converter trimRight.
	self assert: (converter print: ' foo ') = ' foo'.
	converter trimBoth.
	self assert: (converter print: ' foo ') = 'foo'
]

{ #category : 'tests-currency' }
GRPrinterTest >> testSwissCurrency [
	| printer |
	printer := GRPrinter swissCurrency.
	self assert: (printer print: 12.34) = 'CHF 12.35'.
	self assert: (printer print: -12.39) = 'CHF -12.40'
]

{ #category : 'tests-parts-date' }
GRPrinterTest >> testUnpaddedCentury [
	| printer |
	printer := GRPrinter unpaddedCentury.
	self assert: (printer print: (Date year: 1980 month: 1 day: 1)) = '80'.
	self assert: (printer print: (Date year: 2009 month: 1 day: 1)) = '9'
]

{ #category : 'tests-parts-date' }
GRPrinterTest >> testUnpaddedDay [
	| printer |
	printer := GRPrinter unpaddedDay.
	self assert: (printer print: (Date year: 2000 month: 1 day: 4)) = '4'.
	self assert: (printer print: (Date year: 2000 month: 1 day: 19)) = '19'
]

{ #category : 'tests-parts-time' }
GRPrinterTest >> testUnpaddedHour12 [
	| printer |
	printer := GRPrinter unpaddedHour12.
	self assert: (printer print: (Time hour: 5 minute: 0 second: 0)) = '5'.
	self assert: (printer print: (Time hour: 10 minute: 0 second: 0)) = '10'.
	self assert: (printer print: (Time hour: 14 minute: 0 second: 0)) = '2'.
	self assert: (printer print: (Time hour: 23 minute: 0 second: 0)) = '11'
]

{ #category : 'tests-parts-time' }
GRPrinterTest >> testUnpaddedHour24 [
	| printer |
	printer := GRPrinter unpaddedHour24.
	self assert: (printer print: (Time hour: 5 minute: 0 second: 0)) = '5'.
	self assert: (printer print: (Time hour: 10 minute: 0 second: 0)) = '10'.
	self assert: (printer print: (Time hour: 14 minute: 0 second: 0)) = '14'.
	self assert: (printer print: (Time hour: 23 minute: 0 second: 0)) = '23'
]

{ #category : 'tests-parts-time' }
GRPrinterTest >> testUnpaddedMinute [
	| printer |
	printer := GRPrinter unpaddedMinute.
	self assert: (printer print: (Time hour: 0 minute: 5 second: 0)) = '5'.
	self assert: (printer print: (Time hour: 0 minute: 12 second: 0)) = '12'
]

{ #category : 'tests-parts-date' }
GRPrinterTest >> testUnpaddedMonth [
	| printer |
	printer := GRPrinter unpaddedMonth.
	self assert: (printer print: (Date year: 2000 month: 8 day: 1)) = '8'.
	self assert: (printer print: (Date year: 2000 month: 11 day: 1)) = '11'
]

{ #category : 'tests-parts-time' }
GRPrinterTest >> testUnpaddedSecond [
	| printer |
	printer := GRPrinter unpaddedSecond.
	self assert: (printer print: (Time hour: 0 minute: 0 second: 0)) = '0'.
	self assert: (printer print: (Time hour: 0 minute: 0 second: 9)) = '9'.
	self assert: (printer print: (Time hour: 0 minute: 0 second: 12)) = '12'
]

{ #category : 'tests-parts-date' }
GRPrinterTest >> testUnpaddedYear [
	| printer |
	printer := GRPrinter unpaddedYear.
	self assert: (printer print: (Date year: 766 month: 1 day: 1)) = '766'.
	self assert: (printer print: (Date year: 1980 month: 1 day: 1)) = '1980'.
	self assert: (printer print: (Date year: 2009 month: 1 day: 1)) = '2009'
]

{ #category : 'tests-currency' }
GRPrinterTest >> testUsCurrency [
	| printer |
	printer := GRPrinter usCurrency.
	self assert: (printer print: 12.34) = '$12.34'.
	self assert: (printer print: -12.34) = '-$12.34'
]
