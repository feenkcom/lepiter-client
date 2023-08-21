Class {
	#name : #GtApLepiterPageElement,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'pageContainer',
		'page',
		'post',
		'border',
		'server',
		'token',
		'databaseId'
	],
	#category : #'LepiterClient-UI'
}

{ #category : #accessing }
GtApLepiterPageElement >> contextMenuItems [
	self post
		ifNil: [ ^ {'Create Post' -> [ self createPost ].
				'Create and Publish Post'
					-> [ self createPost.
						self publishPost ]} ].

	self post isPublished ifFalse: [ ^ {'Publish Post' -> [ self publishPost ]} ].

	^ {}
]

{ #category : #accessing }
GtApLepiterPageElement >> createPost [
	(self
		sendRequestTo: '/api/createPost'
		with: {'page' -> self page uid asString.
				'database' -> self databaseId} asDictionary)
		readStreamDo: [ :aStream | self post: (LeJsonV4 uniqueInstance deserialize: aStream) ]
]

{ #category : #accessing }
GtApLepiterPageElement >> databaseId [
	^ databaseId
]

{ #category : #accessing }
GtApLepiterPageElement >> databaseId: anObject [
	databaseId := anObject
]

{ #category : #accessing }
GtApLepiterPageElement >> initialize [
	super initialize.

	self hFitContent.
	self vExact: 200.
	self margin: (BlInsets top: 0 left: 0 bottom: 20 right: 30).

	self initializeBorder.
	self initializePageContainer.

	self addChild: border as: #border.
	self addChild: pageContainer as: #pageContainer
]

{ #category : #accessing }
GtApLepiterPageElement >> initializeBorder [
	border := BrVerticalPane new
			vMatchParent;
			hExact: 5;
			visibility: BlVisibility gone;
			geometry: (BlRoundedRectangleGeometry cornerRadius: 4)
]

{ #category : #accessing }
GtApLepiterPageElement >> initializePageContainer [
	pageContainer := LePageSummaryCardElement new
			addAptitude: (BrGlamorousWithContextMenuAptitude
					content: [ BrGlamorousSimpleContextMenuContent new
							items: self contextMenuItems;
							yourself ])
]

{ #category : #accessing }
GtApLepiterPageElement >> page [
	^ page
]

{ #category : #accessing }
GtApLepiterPageElement >> page: anObject [
	page := anObject.
	pageContainer pageViewModel: anObject asContentUIModel
]

{ #category : #accessing }
GtApLepiterPageElement >> post [
	^ post
]

{ #category : #accessing }
GtApLepiterPageElement >> post: anObject [
	post := anObject.
	post
		ifNotNil: [ border
				background: (post isPublished
						ifTrue: [ BrGlamorousColors successBorderColor ]
						ifFalse: [ BrGlamorousColors failureBackgroundColor ]);
				visibility: BlVisibility visible ]
]

{ #category : #accessing }
GtApLepiterPageElement >> publishPost [
	(self
		sendRequestTo: '/api/publishPost'
		with: {'post' -> self post uuid asString} asDictionary)
		readStreamDo: [ :aStream | self post: (LeJsonV4 uniqueInstance deserialize: aStream) ]
]

{ #category : #accessing }
GtApLepiterPageElement >> sendRequestTo: aUrl with: aBody [
	^ ZnClient new beOneShot
		url: self server , aUrl;
		setBearerAuthentication: self token;
		entity: (ZnEntity json: (STONJSON toString: aBody));
		post
]

{ #category : #accessing }
GtApLepiterPageElement >> server [
	^ server
]

{ #category : #accessing }
GtApLepiterPageElement >> server: anObject [
	server := anObject
]

{ #category : #accessing }
GtApLepiterPageElement >> token [
	^ token
]

{ #category : #accessing }
GtApLepiterPageElement >> token: anObject [
	token := anObject
]
