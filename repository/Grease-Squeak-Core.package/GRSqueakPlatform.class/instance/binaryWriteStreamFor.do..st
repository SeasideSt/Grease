file library
binaryWriteStreamFor: aFileReference do: aBlock
	"Open a binary writeStream for aFileReference and evaluate aBlock
	with the stream as argument.
	The stream will be closed after the block has completed."
	FileDirectory default
		fileNamed: aFileReference fullName
		do: aBlock