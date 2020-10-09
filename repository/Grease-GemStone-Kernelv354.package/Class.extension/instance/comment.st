*grease-gemstone-kernelv354
comment
  "override new 3.5.4 comment implementation (answers default GemStone class comment for 
	class instead of nil) and restore pre-3.5.4 behavior (answer '' if no comment 
	defined)"

  "https://github.com/SeasideSt/Grease/issues/111"

  ^ self commentForFileout ifNil: [ '' ]
