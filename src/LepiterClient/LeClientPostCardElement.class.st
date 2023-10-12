Class {
	#name : #LeClientPostCardElement,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'titleElement',
		'thumbElement',
		'descriptionElement',
		'dateAndAuthorElement',
		'publishedIndicator',
		'toolbarElement',
		'publishButton',
		'deleteButton',
		'post'
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
LeClientPostCardElement >> buildToolbarElement [
	^ toolbarElement := BrToolbar new
			aptitude: (BrGlamorousToolbarAptitude new spacing: 5);
			fitContent;
			margin: (BlInsets bottom: 5)";
			addChild: (publishButton := BrButton new
						aptitude: BrGlamorousButtonWithIconAptitude;
						beSmallSize;
						icon: BrGlamorousVectorIcons accept;
						label: 'Publish';
						action: [ self publish ])";
			addChild: (deleteButton := BrButton new
						aptitude: BrGlamorousButtonWithIconAptitude;
						beSmallSize;
						icon: BrGlamorousVectorIcons cancel;
						label: 'Delete';
						action: [ self delete ])
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
LeClientPostCardElement >> delete [
	self post client deletePost: self post.
	self post publishedAt: nil.
	self post publishedUser: nil.
	self post publishedFile: nil
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
	contentContainer addChild: self buildToolbarElement.

	self addChild: self buildPublishedIndicator.
	self addChild: contentContainer
]

{ #category : #accessing }
LeClientPostCardElement >> isPublished: aBoolean [
	aBoolean
		ifTrue: [ publishedIndicator visibility: BlVisibility visible.
			"publishButton visibility: BlVisibility gone."
			deleteButton visibility: BlVisibility visible ]
		ifFalse: [ publishedIndicator visibility: BlVisibility gone.
			"publishButton visibility: BlVisibility visible."
			deleteButton visibility: BlVisibility gone ]
]

{ #category : #accessing }
LeClientPostCardElement >> post [
	^ post
]

{ #category : #accessing }
LeClientPostCardElement >> post: aPost [
	post := aPost.
	self title: aPost title.
	self thumb: aPost thumbnail.
	self description: aPost abstract.
	self dateAndAuthorFrom: aPost.
	self isPublished: aPost isPublished.
]

{ #category : #accessing }
LeClientPostCardElement >> publish [
	| aRenderedPostResponse |
	aRenderedPostResponse := self post client
			createRenderedPost: self post
			page: nil.
	aRenderedPostResponse isSuccess ifFalse: [ ^ aRenderedPostResponse ].

	^ self post client
		publishPost: self post
		withAuthor: ''
		andFile: aRenderedPostResponse filePath
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
