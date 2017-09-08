accessing
use: anObject during: aBlock
  | p hasOldValue oldValue result |
  "Implementation cannot send a supercall to value:during: because:
   - this method needs to return the value
   - the defaultValue may not be invoked here to support throwing errors as defaultValue
   - nil may not remain installed as the default value once the block has finished running"
  p := Processor activeProcess.
  hasOldValue := p environment includesKey: self.
  oldValue := p environmentAt: self.
  [ 
  p environmentAt: self put: anObject.
  result := aBlock value ]
    ensure: [ 
      hasOldValue
        ifFalse: [ p environment removeKey: self ]
        ifTrue: [ p environmentAt: self put: oldValue ] ].
  ^ result