Class {
	#name : 'GRAnsiCharactersRule',
	#superclass : 'GRSlimeTransformationRule',
	#category : 'Grease-Pharo40-Slime',
	#package : 'Grease-Pharo40-Slime'
}

{ #category : 'accessing' }
GRAnsiCharactersRule >> group [
	^ 'ANSI Compatibility'
]

{ #category : 'initialization' }
GRAnsiCharactersRule >> initialize [
	super initialize.
	self rewriteRule
		replace: 'Character value: ``@expr' with: 'Character codePoint: ``@expr';
		replace: '`#source to: `#target' 
			withValueFrom: [ :node |
				RBLiteralNode value: (String streamContents: [ :stream |
					node receiver value codePoint to: node arguments first value codePoint do: [ :code |
						stream nextPut: (Character codePoint: code) ] ]) ]
			when: [ :node | 
				node receiver value isCharacter
					and: [ node arguments first value isCharacter ] ] 
]

{ #category : 'accessing' }
GRAnsiCharactersRule >> name [
	^ 'Characters'
]

{ #category : 'accessing' }
GRAnsiCharactersRule >> rationale [
	^ 'Character value: 64 and $a to: $b is not ANSI compatible.'
]
