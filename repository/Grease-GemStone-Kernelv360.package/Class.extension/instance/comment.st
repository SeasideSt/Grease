*grease-gemstone-kernelv360
comment
  "override new 3.6.0 comment implementation (answers default GemStone class comment for 
	class instead of nil) and restore pre-3.6.0 behavior (answer '' if no comment 
	defined)"

  "https://github.com/SeasideSt/Grease/issues/111"

  ^ self commentForFileout ifNil: [ '' ]
