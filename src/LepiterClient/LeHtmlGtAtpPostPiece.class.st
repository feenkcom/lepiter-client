Class {
	#name : #LeHtmlGtAtpPostPiece,
	#superclass : #LeHtmlGtBookPiece,
	#category : #'LepiterClient-Piece - Model'
}

{ #category : #accessing }
LeHtmlGtAtpPostPiece >> initialize [
	super initialize.

	formatPiece at: #blogTitle put: LeHtmlDatabaseTitlePiece;
	at: #blogSlug put: LeHtmlDatabaseSlugPiece
]
