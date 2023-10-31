baselines
baselinePharo: spec

	spec
		for: #'pharo6.x'
		do: [ spec
				package: 'Grease-Core' with: [ spec includes: #('Grease-Pharo60-Core') ];
				package: 'Grease-Tests-Pharo-Core' with: [ spec requires: #('Grease-Tests-Core') ];
				package: 'Grease-Tests-Core'
					with: [ spec
						requires: #('Grease-Pharo60-Core');
						includes: #('Grease-Tests-Pharo-Core') ];
				package: 'Grease-Pharo60-Core' with: [ spec requires: #('Grease-Core') ] ].

	spec
		for: #(#'pharo7.x' #'pharo8.x')
		do: [ spec
				package: 'Grease-Core' with: [ spec includes: #('Grease-Pharo70-Core') ];
				package: 'Grease-Tests-Pharo-Core' with: [ spec requires: #('Grease-Tests-Core') ];
				package: 'Grease-Tests-Core'
					with: [ spec
						requires: #('Grease-Pharo70-Core');
						includes: #('Grease-Tests-Pharo-Core') ];
				package: 'Grease-Pharo70-Core' with: [ spec requires: #('Grease-Core') ] ].

	spec
		for: #(#'pharo6.x' #'pharo7.x' #'pharo8.x')
		do: [
			spec
				package: 'Grease-Pharo40-Slime' with: [ spec requires: #('Grease-Core') ];
				package: 'Grease-Tests-Slime' with: [ spec requires: #('Grease-Pharo40-Slime') ].
			spec
				group: 'Slime' with: #('Grease-Pharo40-Slime');
				group: 'Slime Tests' with: #('Grease-Tests-Slime') ].

	spec
		for: #(#'pharo9.x')
		do: [
			spec
				package: 'Grease-Core' with: [ spec includes: #('Grease-Pharo90-Core') ];
				package: 'Grease-Tests-Pharo-Core' with: [ spec requires: #('Grease-Tests-Core') ];
				package: 'Grease-Tests-Core'
					with: [ spec
						requires: #('Grease-Pharo90-Core');
						includes: #('Grease-Tests-Pharo-Core') ];
				package: 'Grease-Pharo90-Core' with: [ spec requires: #('Grease-Core') ];
				package: 'Grease-Pharo90-Slime' with: [ spec requires: #('Grease-Core') ];
				package: 'Grease-Tests-Slime' with: [ spec requires: #('Grease-Pharo90-Slime') ].

			spec
				group: 'Slime' with: #('Grease-Pharo90-Slime');
				group: 'Slime Tests' with: #('Grease-Tests-Slime') ].

	spec
		for: #(#'pharo10.x' #'pharo11.x')
		do: [
			spec
				package: 'Grease-Core' with: [ spec includes: #('Grease-Pharo100-Core') ];
				package: 'Grease-Tests-Pharo-Core' with: [ spec requires: #('Grease-Tests-Core') ];
				package: 'Grease-Tests-Core'
					with: [ spec
						requires: #('Grease-Pharo100-Core');
						includes: #('Grease-Tests-Pharo-Core') ];
				package: 'Grease-Pharo100-Core' with: [ spec requires: #('Grease-Core') ];
				package: 'Grease-Pharo90-Slime' with: [ spec requires: #('Grease-Core') ];
				package: 'Grease-Tests-Slime' with: [ spec requires: #('Grease-Pharo90-Slime') ].

			spec
				group: 'Slime' with: #('Grease-Pharo90-Slime');
				group: 'Slime Tests' with: #('Grease-Tests-Slime') ].
			
	spec
		for: #(#'pharo12.x')
		do: [
			spec
				package: 'Grease-Core' with: [ spec includes: #('Grease-Pharo120-Core') ];
				package: 'Grease-Tests-Pharo-Core' with: [ spec requires: #('Grease-Tests-Core') ];
				package: 'Grease-Tests-Core'
					with: [ spec
						requires: #('Grease-Pharo120-Core');
						includes: #('Grease-Tests-Pharo-Core') ];
				package: 'Grease-Pharo100-Core' with: [ spec requires: #('Grease-Core') ];
				package: 'Grease-Pharo120-Slime' with: [ spec requires: #('Grease-Core') ];
				package: 'Grease-Tests-Slime' with: [ spec requires: #('Grease-Pharo120-Slime') ].

			spec
				group: 'Slime' with: #('Grease-Pharo120-Slime');
				group: 'Slime Tests' with: #('Grease-Tests-Slime') ]