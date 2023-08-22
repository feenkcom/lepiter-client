Class {
	#name : #LeHtmlDatabaseTitlePiece,
	#superclass : #Object,
	#traits : 'TLeHtmlPiece',
	#classTraits : 'TLeHtmlPiece classTrait',
	#category : #'LepiterClient-Piece - Model'
}

{ #category : #'api - writing' }
LeHtmlDatabaseTitlePiece >> writeWithContext: aContext [
	aContext serverDatabase ifNotNil: [ :aDatabase | 
		aContext html escape: (aDatabase at: 'name') ]
]
