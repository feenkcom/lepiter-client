Extension { #name : #LeHtmlGtBookPiece }

{ #category : #'*LepiterClient' }
LeHtmlGtBookPiece class >> atpPost [
	^ self fromFile: FileLocator gtResource 
		/ 'feenkcom' 
		/ 'lepiter-atproto-server' 
		/ 'deployment' 
		/ 'atpPost'
		/ 'page-template.html'
]
