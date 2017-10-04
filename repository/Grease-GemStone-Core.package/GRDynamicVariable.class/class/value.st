accessing
value
  "Override required for compatibility in GS2.4 where environmentAt:ifAbsent: is flawed because it can still return nil when absent instead of executing the ifAbsent block"

  ^ Processor activeProcess environment at: self ifAbsent: [ self defaultValue ]