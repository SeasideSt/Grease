Class {
	#name : 'BaselineOfGrease',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfGrease',
	#package : 'BaselineOfGrease'
}

{ #category : 'baselines' }
BaselineOfGrease >> baseline: spec [
	<baseline>

	self baselineCommon: spec.
	self baselineSqueak: spec.
	self baselinePharo: spec.
	self baselineGemStone: spec
]

{ #category : 'baselines' }
BaselineOfGrease >> baselineCommon: spec [

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
				group: 'Slime' with: #('Core');
				group: 'Slime Tests' with: #('Core Tests');
				group: 'Tests' with: #('Core Tests' 'Slime Tests');
				group: 'default' with: #('Slime');
				group: 'Development' with: #('default') ]
]

{ #category : 'baselines' }
BaselineOfGrease >> baselineGemStone: spec [

  spec
    for: #'gemstone'
    do: [ 
      spec
        project: 'GsCore'
          with: [ 
              spec
                className: 'ConfigurationOfGsCore';
                versionString: #'stable';
                repository:
                    'http://seaside.gemtalksystems.com/ss/MetacelloRepository' ];
        project: 'UTF8'
          with: [ 
              spec
                className: 'ConfigurationOfGsMisc';
                versionString: #'stable';
                loads: #('Utf8Encoding');
                repository:
                    'http://seaside.gemtalksystems.com/ss/MetacelloRepository' ];
        project: 'System-Digital-Signatures'
          copyFrom: 'UTF8'
          with: [ spec loads: #('System-Digital-Signatures') ];
        project: 'SMTPMail'
          copyFrom: 'UTF8'
          with: [ spec loads: #('SMTPMail') ].
      spec
        package: 'Grease-Core'
          with: [ 
              spec
                requires: #('GsCore');
                includes: #('Grease-GemStone-Core') ];
        package: 'Grease-Tests-Core'
          with: [ 
              spec
                requires: #('Grease-GemStone-Core') ];
        package: 'Grease-GemStone-Core'
          with: [ 
              spec
                requires:
                  #('Grease-Core' 'GsCore' 'System-Digital-Signatures' 'UTF8' 'SMTPMail') ] ].

  spec
    for: #'gs2.x'
    do: [ 
      spec
        package: 'Grease-GemStone-Core'
          with: [ spec includes: #('Grease-GemStone200-Core') ];
        package: 'Grease-GemStone200-Core'
          with: [ spec requires: #('Grease-GemStone-Core') ] ].
  spec
    for: #'gs2.3.x'
    do: [ 
      spec
        package: 'Grease-GemStone-Core'
          with: [ spec includes: #('Grease-GemStone230-Core') ];
        package: 'Grease-GemStone230-Core'
          with: [ spec requires: #('Grease-GemStone-Core') ] ].
  spec
    for: #'gs2.4.x'
    do: [ 
      spec
        package: 'Grease-GemStone-Core'
          with: [ spec includes: #('Grease-GemStone240-Core') ];
        package: 'Grease-GemStone240-Core'
          with: [ spec requires: #('Grease-GemStone-Core') ] ].
  spec
    for: #(#'gs3.0.x' #'gs3.1.x' #'gs3.2.x')
    do: [ 
      spec
        package: 'Grease-GemStone-Core'
          with: [ spec includes: #('Grease-GemStone300-Core') ];
        package: 'Grease-GemStone300-Core'
          with: [ 
              spec
                requires: #('Grease-GemStone-Core');
                postLoadDoIt: #'initializeLatin1ToUtf8Encodings' ] ].
  spec
    for: #(#'gs3.3.x' #'gs3.4.x' #'gs3.5.x' #'gs3.6.x' #'gs3.7.x' #'gs3.8.x' #'gs3.9.x')
    do: [ 
      spec
        package: 'Grease-GemStone-Core'
          with: [ spec includes: #('Grease-GemStone330-Core') ];
        package: 'Grease-GemStone330-Core'
          with: [ 
              spec
                requires: #('Grease-GemStone-Core');
                postLoadDoIt: #'initializeLatin1ToUtf8Encodings' ] ].

	spec for: #(#'gs2.x' #'gs3.0.x' #'gs3.1.x') 
		do:[
	      spec
        package: 'Grease-Tests-GemStone-Core'
		    with:[ spec requires: 'Grease-Tests-Core' ];
		  package: 'Grease-Tests-Core'
        	 with: [ spec includes: 'Grease-Tests-GemStone-Core' ] ].

  spec
    for: #( #'gs3.5.4.x' #'gs3.5.5.x' #'gs3.5.6.x' #'gs3.5.7.x' #'gs3.5.8.x' #'gs3.5.9.x' )
    do: [ 
      spec
        package: 'Grease-GemStone-Core'
          with: [ spec includes: #('Grease-GemStone-Kernelv354') ];
        package: 'Grease-GemStone-Kernelv354'
          with: [ 
              spec
                requires: #('Grease-GemStone-Core') ] ].
  spec
    for: #( #'gs3.6.x' #'gs3.7.x' #'gs3.8.x' #'gs3.9.x')
    do: [ 
      spec
        package: 'Grease-GemStone-Core'
          with: [ spec includes: #('Grease-GemStone-Kernelv360') ];
        package: 'Grease-GemStone-Kernelv360'
          with: [ 
              spec
                requires: #('Grease-GemStone-Core') ] ].
  spec
    for: #( #'gs3.7.x' #'gs3.8.x' #'gs3.9.x')
    do: [ 
      spec
        package: 'Grease-GemStone-Core'
          with: [ spec includes: #('Grease-GemStone-Kernelv370') ];
        package: 'Grease-GemStone-Kernelv370'
          with: [ 
              spec
                requires: #('Grease-GemStone-Core') ] ].
  spec
    for: #(#'gs3.2.x' #'gs3.3.x' #'gs3.4.x' #'gs3.5.x' #'gs3.6.x' #'gs3.7.x' #'gs3.8.x' #'gs3.9.x')
    do: [ 
      spec
        package: 'Grease-Tests-GemStone32-Core'
		    with:[ spec requires: 'Grease-Tests-Core' ];
		  package: 'Grease-Tests-Core'
        	 with: [ spec includes: 'Grease-Tests-GemStone32-Core' ] ]
]

{ #category : 'baselines' }
BaselineOfGrease >> baselinePharo: spec [

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
		for: #(#'pharo10.x' #'pharo11.x' #'pharo12.x' #'pharo13.x' #'pharo14.x')
		do: [
			spec
				package: 'Grease-Core' with: [ spec includes: #('Grease-Pharo100-Core') ];
				package: 'Grease-Tests-Pharo-Core' with: [ spec requires: #('Grease-Tests-Core') ];
				package: 'Grease-Tests-Core'
					with: [ spec
						requires: #('Grease-Pharo100-Core');
						includes: #('Grease-Tests-Pharo-Core') ];
				package: 'Grease-Pharo100-Core' with: [ spec requires: #('Grease-Core') ];
				package: 'Grease-Pharo110-Slime-Core' with: [ spec requires: #('Grease-Core') ];
				package: 'Grease-Pharo110-Slime-Portability' with: [ spec requires: #('Grease-Pharo110-Slime-Core') ];
				package: 'Grease-Tests-Pharo-Slime' with: [ spec requires: #('Grease-Pharo110-Slime-Portability') ].

			spec
				group: 'Slime' with: #('Grease-Pharo110-Slime-Core');
				group: 'Slime Portability' with: #('Slime' 'Grease-Pharo110-Slime-Portability');
				group: 'Slime Tests' with: #('Grease-Pharo110-Slime-Portability' 'Grease-Tests-Pharo-Slime');
				group: 'Development' with: #('Slime Portability') ]

]

{ #category : 'baselines' }
BaselineOfGrease >> baselineSqueak: spec [
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
]

{ #category : 'doits' }
BaselineOfGrease >> initializeLatin1ToUtf8Encodings [
	"Gemstone only"
	(Smalltalk at: #GRUtf8CodecStream) initialize
]

{ #category : 'accessing' }
BaselineOfGrease >> projectClass [
  Smalltalk at: #'MetacelloCypressBaselineProject' ifPresent: [ :cl | ^ cl ].
  ^ super projectClass
]
