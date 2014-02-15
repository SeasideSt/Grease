file-library
contentsOfFile: aString binary: aBoolean
	| stream dir file |
	[
	file := GsFile openReadOnServer: aString.
		[stream := RWBinaryOrTextStream on: file contents.
		aBoolean 
			ifTrue: [ stream binary ]
			ifFalse: [ stream ascii ]. 
		^stream contents ] ensure: [ stream close ]] ensure: [ file close ].