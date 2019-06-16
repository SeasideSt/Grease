baselines
baselinePharo: spec
	spec
		for: #(#'pharo4.x' #'pharo5.x')
		do: [ spec
				package: 'Grease-Core'
					with: [ spec includes: #('Grease-Pharo30-Core') ];
				package: 'Grease-Tests-Core'
					with: [ spec
						requires: #('Grease-Pharo30-Core');
						includes: #('Grease-Tests-Pharo-Core') ];
				package: 'Grease-Pharo30-Core'
					with: [ spec requires: #('Grease-Core') ];
				package: 'Grease-Tests-Pharo-Core'
					with: [ spec requires: #('Grease-Tests-Core') ];
				package: 'Grease-Pharo40-Slime'
					with: [ spec requires: #('Grease-Core') ];
				package: 'Grease-Tests-Slime'
					with: [ spec requires: #('Grease-Pharo40-Slime') ].
			spec
				group: 'Slime' with: #('Grease-Pharo40-Slime');
				group: 'Slime Tests' with: #('Grease-Tests-Slime') ].
	spec
		for: #'pharo6.x'
		do: [ spec
				package: 'Grease-Core'
					with: [ spec includes: #('Grease-Pharo60-Core') ];
				package: 'Grease-Tests-Core'
					with: [ spec
						requires: #('Grease-Pharo60-Core');
						includes: #('Grease-Tests-Pharo-Core') ];
				package: 'Grease-Pharo60-Core'
					with: [ spec requires: #('Grease-Core') ];
				package: 'Grease-Tests-Pharo-Core'
					with: [ spec requires: #('Grease-Tests-Core') ];
				package: 'Grease-Pharo40-Slime'
					with: [ spec requires: #('Grease-Core') ];
				package: 'Grease-Tests-Slime'
					with: [ spec requires: #('Grease-Pharo40-Slime') ].
			spec
				group: 'Slime' with: #('Grease-Pharo40-Slime');
				group: 'Slime Tests' with: #('Grease-Tests-Slime') ].
	spec
		for: #(#'pharo7.x')
		do: [ spec
				package: 'Grease-Core'
					with: [ spec includes: #('Grease-Pharo70-Core') ];
				package: 'Grease-Tests-Core'
					with: [ spec
						requires: #('Grease-Pharo70-Core');
						includes: #('Grease-Tests-Pharo-Core') ];
				package: 'Grease-Pharo70-Core'
					with: [ spec requires: #('Grease-Core') ];
				package: 'Grease-Tests-Pharo-Core'
					with: [ spec requires: #('Grease-Tests-Core') ];
				package: 'Grease-Pharo40-Slime'
					with: [ spec requires: #('Grease-Core') ];
				package: 'Grease-Tests-Slime'
					with: [ spec requires: #('Grease-Pharo40-Slime') ].
			spec
				group: 'Slime' with: #('Grease-Pharo40-Slime');
				group: 'Slime Tests' with: #('Grease-Tests-Slime') ].
	spec
		for: #(#'pharo8.x')
		do: [ spec
				package: 'Grease-Core'
					with: [ spec includes: #('Grease-Pharo70-Core') ];
				package: 'Grease-Tests-Core'
					with: [ spec
						requires: #('Grease-Pharo70-Core');
						includes: #('Grease-Tests-Pharo-Core') ];
				package: 'Grease-Pharo70-Core'
					with: [ spec requires: #('Grease-Core') ];
				package: 'Grease-Tests-Pharo-Core'
					with: [ spec requires: #('Grease-Tests-Core') ];
				package: 'Grease-Pharo40-Slime'
					with: [ spec requires: #('Grease-Core') ];
				package: 'Grease-Tests-Slime'
					with: [ spec requires: #('Grease-Pharo40-Slime') ].
			spec
				group: 'Slime' with: #('Grease-Pharo40-Slime');
				group: 'Slime Tests' with: #('Grease-Tests-Slime') ]
