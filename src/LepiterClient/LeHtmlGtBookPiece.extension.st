Extension { #name : #LeHtmlGtBookPiece }

{ #category : #'*LepiterClient' }
LeHtmlGtBookPiece class >> atpPost [
	^ self fromFile: FileLocator gtResource 
		/ 'feenkcom' 
		/ 'lepiter-client' 
		/ 'templates'
		/ 'page-template.html'
]
