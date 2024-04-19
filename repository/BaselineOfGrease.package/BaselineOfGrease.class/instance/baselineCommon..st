baselines
baselineCommon: spec

	spec
		for: #common
		do: [ spec blessing: #baseline.
			spec
				package: 'Grease-Core';
				package: 'Grease-Tests-Core'
					with: [ spec requires: #('Grease-Core') ].
			spec
				group: 'Core' with: #('Grease-Core');
				group: 'Core Tests' with: #('Grease-Tests-Core');
				group: 'Tests' with: #('Core Tests' 'Slime Tests');
				group: 'default' with: #('Slime') ]