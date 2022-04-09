accessing
supportedEncodingNames
	"answers the names of the encodings supported by this class"

	| all |
	all := ZnCharacterEncoder knownEncodingIdentifiers asOrderedCollection.
	(all includes: 'utf8')
		ifTrue:[ all addAll: #('utf-8' 'UTF-8') ].
	(all includes: 'utf16')
		ifTrue:[ all addAll: #('utf-16' 'UTF-16') ].
	(all includes: 'macroman')
		ifTrue:[ all add: 'mac-roman' ].
	^ all