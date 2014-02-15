factory-http
isoTime
	"Ansers a printer that formats time accoring to ISO(HH:MM:SS) E.g. 12:23:34"
	
	^ self paddedHour24 , $: , self paddedMinute , $: , self paddedSecond