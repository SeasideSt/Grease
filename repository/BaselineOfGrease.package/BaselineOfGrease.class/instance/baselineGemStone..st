baseline
baselineGemStone: spec
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
                requires: #('Grease-GemStone-Core');
                includes: #('Grease-Tests-GemStone-Core') ];
        package: 'Grease-GemStone-Core'
          with: [ 
              spec
                requires:
                  #('Grease-Core' 'GsCore' 'System-Digital-Signatures' 'UTF8' 'SMTPMail') ];
        package: 'Grease-Tests-GemStone-Core'
          with: [ spec requires: #('Grease-Tests-Core') ] ].
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
    for: #(#'gs3.3.x' #'gs3.4.x' #'gs3.5.x' #'gs3.6.x')
    do: [ 
      spec
        package: 'Grease-GemStone-Core'
          with: [ spec includes: #('Grease-GemStone330-Core') ];
        package: 'Grease-GemStone330-Core'
          with: [ 
              spec
                requires: #('Grease-GemStone-Core');
                postLoadDoIt: #'initializeLatin1ToUtf8Encodings' ] ].
  spec
    for: #( #'gs3.5.4.x' #'gs3.5.5.x')
    do: [ 
      spec
        package: 'Grease-GemStone-Core'
          with: [ spec includes: #('Grease-GemStone-Kernelv354') ];
        package: 'Grease-GemStone-Kernelv354'
          with: [ 
              spec
                requires: #('Grease-GemStone-Core') ] ].
  spec
    for: #( #'gs3.6.x')
    do: [ 
      spec
        package: 'Grease-GemStone-Core'
          with: [ spec includes: #('Grease-GemStone-Kernelv360') ];
        package: 'Grease-GemStone-Kernelv360'
          with: [ 
              spec
                requires: #('Grease-GemStone-Core') ] ].
  spec
    for: #(#'gs3.2.x' #'gs3.3.x' #'gs3.4.x' #'gs3.5.x' #'gs3.6.x')
    do: [ 
      spec
        package: 'Grease-Tests-GemStone-Core'
        with: [ spec file: 'Grease-Tests-GemStone-Core.v32' ] ]
