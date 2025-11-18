Class {
	#name : 'GRDynamicVariable',
	#superclass : 'DynamicVariable',
	#category : 'Grease-GemStone-Core',
	#package : 'Grease-GemStone-Core'
}

{ #category : 'defaults' }
GRDynamicVariable class >> default [
  ^ self defaultValue
]

{ #category : 'defaults' }
GRDynamicVariable class >> defaultValue [
  ^ nil
]

{ #category : 'accessing' }
GRDynamicVariable class >> use: anObject during: aBlock [
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
]

{ #category : 'accessing' }
GRDynamicVariable class >> value [
  "Override required for compatibility in GS2.4 where environmentAt:ifAbsent: is flawed because it can still return nil when absent instead of executing the ifAbsent block"

  ^ Processor activeProcess environment at: self ifAbsent: [ self defaultValue ]
]
