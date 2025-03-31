Extension { #name : #LeHtmlDoubleBracketFormatPiece }

{ #category : #'*LepiterClient' }
LeHtmlDoubleBracketFormatPiece class >> atpPostMetaData [
	^ self fromFile: FileLocator gtResource 
		/ 'feenkcom' 
		/ 'lepiter-client' 
		/ 'templates'
		/ 'page-meta-data-template.html'
]
