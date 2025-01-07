Class {
	#name : #LeHtmlGtAtpPostPiece,
	#superclass : #LeHtmlGtBookPiece,
	#category : #'LepiterClient-Piece - Model'
}

{ #category : #accessing }
LeHtmlGtAtpPostPiece >> gtOutputFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Output';
		priority: 20;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ String streamContents: [ :aStream | 
			self writeWithContext: (LeClientHtmlContext new stream: aStream) ] ]
]

{ #category : #accessing }
LeHtmlGtAtpPostPiece >> initialize [
	super initialize.

	formatPiece
		at: #blogTitle put: LeHtmlDatabaseTitlePiece;
		at: #blogSlug put: LeHtmlDatabaseSlugPiece;
		at: #urlAttribute put: LeHtmlGtApUrlAttributePiece;
		at: #postMeta put: (LeHtmlConditionPiece new
			condition: [ :aContext | aContext author isNotNil ];
			piece: (LeHtmlFormatPiece atpPostMetaData
				at: #date put: LeHtmlDatePiece;
				at: #author put: LeHtmlAuthorPiece))
]
