Extension { #name : #LeHtmlFormatPiece }

{ #category : #'*LepiterClient' }
LeHtmlFormatPiece class >> atpPostMetaData [
	^ self fromFile: FileLocator gtResource 
		/ 'feenkcom' 
		/ 'lepiter-client' 
		/ 'templates'
		/ 'page-meta-data-template.html'
]
