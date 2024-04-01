running
basicCheck: anEntity

	^ anEntity isMessage and:[ self methodNames includes: anEntity selector ]
