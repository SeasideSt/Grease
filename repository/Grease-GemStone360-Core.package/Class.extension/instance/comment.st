*grease-gemstone360-core
comment
  "override new 3.6.0 comment implementation (answers default GemSTone class comment for 
	class instead of nil) and restore pre-3.6.0 behavior (answer nil if no comment 
	defined)"

  "https://github.com/SeasideSt/Grease/issues/111"

  ^ self commentForFileout