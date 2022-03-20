accessing
tempNamed: aString
  | index |
  index := self tempNames indexOf: aString asSymbol.
  index = 0
    ifTrue: [ Error raiseSignal: 'No such temp: ' , aString ].
  ^ self tempAt: index