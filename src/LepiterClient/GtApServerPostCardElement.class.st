Class {
	#name : #GtApServerPostCardElement,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'titleElement',
		'thumbElement',
		'descriptionElement',
		'dateAndAuthorElement',
		'publishedIndicator'
	],
	#category : #'LepiterClient-UI'
}

{ #category : #accessing }
GtApServerPostCardElement >> buildDescriptionElement [
	^ descriptionElement := BrEditor new
			beReadOnlyWithoutSelection;
			aptitude: BrGlamorousRegularEditorAptitude;
			hMatchParent;
			vFitContent;
			margin: (BlInsets
					top: 0
					left: 0
					bottom: 10
					right: 0)
]

{ #category : #accessing }
GtApServerPostCardElement >> buildPublishedIndicator [
	^ publishedIndicator := BrVerticalPane new
			vMatchParent;
			hExact: 5;
			visibility: BlVisibility gone;
			background: BrGlamorousColors successBorderColor;
			geometry: (BlRoundedRectangleGeometry cornerRadius: 4)
]

{ #category : #accessing }
GtApServerPostCardElement >> buildThumbElement [
	^ thumbElement := BrAsyncFileWidget new
			hMatchParent;
			vExact: 200
]

{ #category : #accessing }
GtApServerPostCardElement >> buildTitleElement [
	^ titleElement := BrLabel new aptitude: BrGlamorousLabelAptitude new bold
]

{ #category : #accessing }
GtApServerPostCardElement >> dateAndAuthorElement [
	^ dateAndAuthorElement := BrLabel new
			aptitude: (BrGlamorousLabelAptitude new foreground: BrGlamorousColors formLabelTextColor)
]

{ #category : #accessing }
GtApServerPostCardElement >> dateAndAuthorFrom: aPost [
	aPost publishedAt
		ifNil: [ dateAndAuthorElement visibility: BlVisibility gone ]
		ifNotNil: [ dateAndAuthorElement
				visibility: BlVisibility visible;
				text: 'Published by ' asRopedText , aPost publishedUser asRopedText bold
						, ' at ' asRopedText
						, aPost publishedAt printToMinute asRopedText bold ]
]

{ #category : #accessing }
GtApServerPostCardElement >> description: aString [
	descriptionElement
		styler: (LeSnippetStyler new
				snippetViewModel: (LeTextSnippet new text: aString asRopedText) asSnippetViewModel);
		text: aString
]

{ #category : #accessing }
GtApServerPostCardElement >> initialize [
	| contentContainer |
	super initialize.

	self
		hExact: 300;
		vFitContent;
		background: Color white;
		aptitude: BrShadowAptitude;
		margin: (BlInsets all: 5).

	contentContainer := BrVerticalPane new
			hMatchParent;
			padding: (BlInsets all: 10);
			vFitContent.

	contentContainer addChild: self buildTitleElement.
	contentContainer addChild: self buildThumbElement.
	contentContainer addChild: self buildDescriptionElement.
	contentContainer addChild: self dateAndAuthorElement.

	self addChild: self buildPublishedIndicator.
	self addChild: contentContainer
]

{ #category : #accessing }
GtApServerPostCardElement >> isPublished: aBoolean [
	aBoolean
		ifTrue: [ publishedIndicator visibility: BlVisibility visible ]
		ifFalse: [ publishedIndicator visibility: BlVisibility gone ]
]

{ #category : #accessing }
GtApServerPostCardElement >> post: aPost [
	self title: aPost title.
	self thumb: aPost thumbnail.
	self description: aPost abstract.
	self dateAndAuthorFrom: aPost.
	self isPublished: aPost isPublished.
]

{ #category : #accessing }
GtApServerPostCardElement >> thumb: anObject [
	anObject isEmptyOrNil
		ifTrue: [ thumbElement visibility: BlVisibility gone ]
		ifFalse: [ thumbElement url: anObject ]
]

{ #category : #accessing }
GtApServerPostCardElement >> title: aString [
	titleElement text: aString
]
