accessing
use: anObject during: aBlock
  | p oldValue result |
  "We cannot just do a super call to value:during: because the GS implementation does not return a result value and also does not produce an error when the dynamic var was not found."
  p := Processor activeProcess.
  oldValue := p environmentAt: self.
  [ 
  p environmentAt: self put: anObject.
  result := aBlock value ]
    ensure: [ p environmentAt: self put: oldValue ].
  ^ result