Class {
	#name : #LeHtmlGtApUrlAttributePiece,
	#superclass : #LeHtmlPageUrlAttributePiece,
	#category : #'LepiterClient-Piece - Model'
}

{ #category : #accessing }
LeHtmlGtApUrlAttributePiece >> defaultBaseUrl [
	^ 'https://lepiter.io/' asZnUrl
]

{ #category : #accessing }
LeHtmlGtApUrlAttributePiece >> writeWithContext: aContext [
	| anUrl |
	anUrl := self baseUrl.

	aContext serverDatabase
		ifNotNil: [ :aDatabase | anUrl := anUrl / (aDatabase at: 'slug') ].

	aContext pagePath
		ifNil: [ anUrl := anUrl / aContext pageLink fileName ]
		ifNotNil: [ :aPath | anUrl := anUrl / aPath ].

	aContext html escapeAttributeValue: anUrl asString
]
