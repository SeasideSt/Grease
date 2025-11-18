Extension { #name : 'GRPlatformTest' }

{ #category : '*grease-tests-gemstone-core' }
GRPlatformTest >> writeToFile: aStringOrByteArray withFileNameDo: aBlock [
  | fileName directory |
  fileName := 'GRGemStonePlatformTest'.
  directory := ServerFileDirectory default.
  [ 
  GRPlatform current
    write: aStringOrByteArray
    toFile: fileName
    inFolder: directory fullName.
  aBlock value: directory fullName , GRPlatform current pathSeparator , fileName ]
    ensure: [ directory deleteFileNamed: fileName ]
]
