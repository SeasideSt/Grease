accessing
supportedEncodingNames
	"answers the names of the encodings supported by this class"

	| all |
	all := ZnCharacterEncoder knownEncodingIdentifiers asOrderedCollection.
	"We include some (but not all) alternative names for encodings, providing some backwards compatibility with TextConverter encoding names. Make a PR if you need more."
	(all includes: 'utf8')
		ifTrue:[ all addAll: #('utf-8' 'UTF-8') ].
	(all includes: 'utf16')
		ifTrue:[ all addAll: #('utf-16' 'UTF-16') ].
	(all includes: 'macroman')
		ifTrue:[ all add: 'mac-roman' ].
	(all includes: 'cp1252')
		ifTrue:[ all add: 'cp-1252' ].
	^ all