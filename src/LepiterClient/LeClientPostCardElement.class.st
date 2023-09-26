Class {
	#name : #LeClientPostCardElement,
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
LeClientPostCardElement >> buildDescriptionElement [
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
LeClientPostCardElement >> buildPublishedIndicator [
	^ publishedIndicator := BrVerticalPane new
			vMatchParent;
			hExact: 5;
			visibility: BlVisibility gone;
			background: BrGlamorousColors successBorderColor;
			geometry: (BlRoundedRectangleGeometry cornerRadius: 4)
]

{ #category : #accessing }
LeClientPostCardElement >> buildThumbElement [
	^ thumbElement := BrAsyncFileWidget new
			hMatchParent;
			vExact: 200
]

{ #category : #accessing }
LeClientPostCardElement >> buildTitleElement [
	^ titleElement := BrLabel new aptitude: BrGlamorousLabelAptitude new bold
]

{ #category : #accessing }
LeClientPostCardElement >> dateAndAuthorElement [
	^ dateAndAuthorElement := BrLabel new
			aptitude: (BrGlamorousLabelAptitude new foreground: BrGlamorousColors formLabelTextColor)
]

{ #category : #accessing }
LeClientPostCardElement >> dateAndAuthorFrom: aPost [
	aPost publishedAt
		ifNil: [ dateAndAuthorElement visibility: BlVisibility gone ]
		ifNotNil: [ dateAndAuthorElement
				visibility: BlVisibility visible;
				text: 'Published by ' asRopedText , aPost publishedUser asRopedText bold
						, ' at ' asRopedText
						, aPost publishedAt printToMinute asRopedText bold ]
]

{ #category : #accessing }
LeClientPostCardElement >> description: aString [
	descriptionElement
		styler: (LeSnippetStyler new
				snippetViewModel: (LeTextSnippet new text: aString asRopedText) asSnippetViewModel);
		text: aString
]

{ #category : #accessing }
LeClientPostCardElement >> initialize [
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
LeClientPostCardElement >> isPublished: aBoolean [
	aBoolean
		ifTrue: [ publishedIndicator visibility: BlVisibility visible ]
		ifFalse: [ publishedIndicator visibility: BlVisibility gone ]
]

{ #category : #accessing }
LeClientPostCardElement >> post: aPost [
	self title: aPost title.
	self thumb: aPost thumbnail.
	self description: aPost abstract.
	self dateAndAuthorFrom: aPost.
	self isPublished: aPost isPublished.
]

{ #category : #accessing }
LeClientPostCardElement >> thumb: anObject [
	anObject isEmptyOrNil
		ifTrue: [ thumbElement visibility: BlVisibility gone ]
		ifFalse: [ thumbElement url: anObject ]
]

{ #category : #accessing }
LeClientPostCardElement >> title: aString [
	titleElement text: aString
]
