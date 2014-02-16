baseline
greaseCoreAndTestsForSqueakAndPharo1x: spec
	spec
		package: 'Grease-Core' with: [ spec includes: #('Grease-Pharo-Core') ];
		package: 'Grease-Tests-Core' with: [ spec includes: #('Grease-Tests-Pharo-Core') ];
		package: 'Grease-Pharo-Core' with: [ spec requires: #('Grease-Core') ];
		package: 'Grease-Tests-Pharo-Core' with: [ spec requires: #('Grease-Tests-Core') ]