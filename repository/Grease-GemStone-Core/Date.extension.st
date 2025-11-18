Extension { #name : 'Date' }

{ #category : '*grease-gemstone-core' }
Date class >> daysInMonthNumber: monthNumber forYear: yearInteger [

	^(Date newDay: 1 monthNumber: monthNumber year: yearInteger) daysInMonth
]
