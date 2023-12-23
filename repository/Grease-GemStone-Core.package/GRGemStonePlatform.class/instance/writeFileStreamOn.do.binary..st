files
writeFileStreamOn: fileName do: aBlock binary: isBinary
  | stream |
  stream := BinaryOrTextFile open: fileName mode: 'w+b' onClient: false.
  stream := isBinary
    ifTrue: [ stream binary ]
    ifFalse: [ stream ascii ].
  [ aBlock value: stream ]
    ensure: [ stream close ]