Class {
	#name : #LeHtmlDatabaseSlugPiece,
	#superclass : #Object,
	#traits : 'TLeHtmlPiece',
	#classTraits : 'TLeHtmlPiece classTrait',
	#category : #'LepiterClient-Piece - Model'
}

{ #category : #'api - writing' }
LeHtmlDatabaseSlugPiece >> writeWithContext: aContext [
	aContext serverDatabase ifNotNil: [ :aDatabase | 
		aContext html escape: aDatabase slug ]
]
