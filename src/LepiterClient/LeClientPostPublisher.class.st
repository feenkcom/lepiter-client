Class {
	#name : #LeClientPostPublisher,
	#superclass : #LeClientCommand,
	#instVars : [
		'page',
		'serverDatabaseId',
		'createOrUpdatePost',
		'pagePublisher',
		'post'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientPostPublisher >> commands [
	^ LeClientUtility collectionWithoutNilItemsFrom: {pagePublisher. createOrUpdatePost}
]

{ #category : #accessing }
LeClientPostPublisher >> description [
	^ 'Publish post: ' , self page title
]

{ #category : #'api - actions' }
LeClientPostPublisher >> execute [
	<return: #TLeClientResponse>
	| aPageResponse aPostResponse aResponse |
	self
		ifSuccess: [ ^ self lastResponse ]
		ifFailure: [  "execute again" ]
		ifNone: [  "execute" ].
	
	aPageResponse := pagePublisher execute.
	aPageResponse
		ifSuccess: [ aPostResponse := createOrUpdatePost execute ]
		ifFailure: [ aPostResponse := LeClientNoResponse new ]
		ifNone: [ aPostResponse := LeClientNoResponse new ].
		
	aResponse := LeClientMultiResponse new 
		subresponses: {aPageResponse. aPostResponse}.
	self addResponse: aResponse.
	^ aResponse
]

{ #category : #private }
LeClientPostPublisher >> onServerDatabaseIdChange [
	createOrUpdatePost
		ifNotNil: [ :aCommand | 
			aCommand onSuccess serverDatabaseId: serverDatabaseId.
			aCommand onNotFound serverDatabaseId: serverDatabaseId ].
	pagePublisher
		ifNotNil: [ :aCommand | aCommand serverDatabaseId: serverDatabaseId ]
]

{ #category : #accessing }
LeClientPostPublisher >> page [
	<return: #LePage>
	^ page
]

{ #category : #accessing }
LeClientPostPublisher >> page: aPage [
	page := aPage
]

{ #category : #accessing }
LeClientPostPublisher >> post [
	<return: #LeClientPost>
	^ post
]

{ #category : #accessing }
LeClientPostPublisher >> post: aPost [
	post := aPost
]

{ #category : #'api - actions' }
LeClientPostPublisher >> prepare [
	self preparePage.
	self prepareCreateOrUpdatePost
]

{ #category : #private }
LeClientPostPublisher >> prepareCreateOrUpdatePost [
	createOrUpdatePost := LeClientCondition new
			description: 'Create or update post: ' , page title;
			context: context;
			check: (LeClientCheckPostExist new
					context: context;
					page: page);
			onSuccess: (LeClientApiUpdatePost new
						context: context;
						page: page;
						post: post;
						serverDatabaseId: serverDatabaseId)
				with: [ :aCheckResponse :aSuccessCommand | 
					aSuccessCommand postId: aCheckResponse model uuid ];
			onNotFound: (LeClientApiCreatePost new
					context: context;
					page: page;
					post: post;
					serverDatabaseId: serverDatabaseId).

	createOrUpdatePost prepare
]

{ #category : #private }
LeClientPostPublisher >> preparePage [
	pagePublisher := LeClientPagePublisher new
			context: context;
			page: page;
			serverDatabaseId: serverDatabaseId.
	pagePublisher prepare
]

{ #category : #accessing }
LeClientPostPublisher >> serverDatabaseId [
	<return: #String>
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientPostPublisher >> serverDatabaseId: aString [
	serverDatabaseId := aString.
	self onServerDatabaseIdChange
]
