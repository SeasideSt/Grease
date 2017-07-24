accessing
value: anObject during: aBlock
	| p oldValue |
	p := Processor activeProcess.
	oldValue := p psValueAt: index.
	^ [ 
		p psValueAt: index put: anObject.
		aBlock value ] ensure: [ p psValueAt: index put: oldValue ]