baseline
baselineSqueak: spec
	<baseline>
	spec
		for: #squeak
		do: [ spec
				project: 'Refactoring-Core'
				with: [ spec
						className: 'ConfigurationOfRefactoringBrowser';
						versionString: #stable;
						loads: #('Core');
						repository: 'http://www.squeaksource.com/MetacelloRepository' ].
			spec
				package: 'Grease-Tests-Core' with: [ spec includes: #('Grease-Tests-Squeak-Core') ];
				package: 'Grease-Tests-Squeak-Core' with: [ spec requires: #('Grease-Tests-Core') ];
				package: 'Grease-Slime' with: [ spec requires: #('Refactoring-Core' 'Grease-Core') ];
				package: 'Grease-Tests-Slime' with: [ spec requires: #('Grease-Slime') ].
			spec
				group: 'Slime' with: #('Grease-Slime');
				group: 'Slime Tests' with: #('Grease-Tests-Slime') ].
			
	spec
		for: #'squeak5.x'
		do: [ spec
				package: 'Grease-Core' with: [ spec includes: #('Grease-Squeak5-Core') ];
				package: 'Grease-Tests-Core' with: [ spec includes: #('Grease-Tests-Squeak5-Core') ];
				package: 'Grease-Squeak5-Core' with: [ spec requires: #('Grease-Core') ];
				package: 'Grease-Tests-Squeak5-Core' with: [ spec requires: #('Grease-Tests-Squeak-Core') ] ].
			
	spec
		for: #'squeak6.x'
		do: [ spec
				package: 'Grease-Core' with: [ spec includes: #('Grease-Squeak6-Core') ];
				package: 'Grease-Tests-Core' with: [ spec includes: #('Grease-Tests-Squeak6-Core') ];
				package: 'Grease-Squeak6-Core' with: [ spec requires: #('Grease-Core') ];
				package: 'Grease-Tests-Squeak6-Core' with: [ spec requires: #('Grease-Tests-Squeak-Core') ] ]