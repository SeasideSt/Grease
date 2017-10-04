accessing
value
  "Override required for compatibility in GS2.4"

  ^ Processor activeProcess environmentAt: self ifAbsent: [ self default ]