baselines
baselineSqueak: spec
	spec
		for: #(#'squeak6.x')
		do: [
			spec
				project: 'Refactoring-Core'
				with: [ spec
						className: 'ConfigurationOfRefactoringBrowser';
						versionString: #stable;
						loads: #('Core');
						repository: 'http://www.squeaksource.com/MetacelloRepository' ].
			spec
				package: 'Grease-Core'
					with: [ spec includes: #('Grease-Squeak6-Core') ];
				package: 'Grease-Tests-Core'
					with: [ spec
						requires: #('Grease-Squeak6-Core');
						includes: #('Grease-Tests-Squeak6-Core') ];
				package: 'Grease-Squeak6-Core'
					with: [ spec requires: #('Grease-Core') ];
				package: 'Grease-Tests-Squeak6-Core'
					with: [ spec requires: #('Grease-Tests-Core') ] ]