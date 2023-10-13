Class {
	#name : #LeClientRenderedPostOfPagePublisher,
	#superclass : #LeClientCommand,
	#instVars : [
		'databaseCommand',
		'page',
		'postPublisher',
		'post',
		'renderedPost',
		'publishPost',
		'authorName'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientRenderedPostOfPagePublisher >> authorName [
	^ authorName
]

{ #category : #accessing }
LeClientRenderedPostOfPagePublisher >> authorName: anObject [
	authorName := anObject
]

{ #category : #accessing }
LeClientRenderedPostOfPagePublisher >> commands [
	^ LeClientUtility
		collectionWithoutNilItemsFrom: {databaseCommand.
				postPublisher.
				renderedPost.
				publishPost}
]

{ #category : #accessing }
LeClientRenderedPostOfPagePublisher >> databaseName: aDatabaseName [
	databaseCommand := LeClientDatabaseNameSearcher new
			context: self context;
			databaseName: aDatabaseName
]

{ #category : #accessing }
LeClientRenderedPostOfPagePublisher >> description [
	^ String
		streamContents: [ :aStream | 
			aStream
				nextPutAll: 'Publish page as post: ';
				nextPutAll: (page ifNotNil: #title ifNil: [ '<undefined>' ]) ]
]

{ #category : #'api - actions' }
LeClientRenderedPostOfPagePublisher >> execute [
	| aDbResponse aPostResponse aRenderedPostResponse aPublishPostResponse aResponse |
	self
		ifSuccess: [ :aPreviousResponse | ^ aPreviousResponse ]
		ifFailure: [  "repeat" ]
		ifNone: [  "execute" ].

	aDbResponse := databaseCommand execute.
	aPostResponse := aDbResponse
			ifSuccess: [ postPublisher
					serverDatabaseId: aDbResponse databaseId;
					execute ]
			ifFailure: [ LeClientCannotExecute new ]
			ifNone: [ LeClientCannotExecute new ].
	aRenderedPostResponse := aPostResponse
			ifSuccess: [ renderedPost
					post: aPostResponse model;
					serverDatabase: aDbResponse database;
					execute ]
			ifFailure: [ LeClientCannotExecute new ]
			ifNone: [ LeClientCannotExecute new ].
	aPublishPostResponse := aRenderedPostResponse
			ifSuccess: [ publishPost
					post: aRenderedPostResponse post;
					filePath: aRenderedPostResponse filePath;
					execute ]
			ifFailure: [ LeClientCannotExecute new ]
			ifNone: [ LeClientCannotExecute new ].

	aResponse := LeClientMultiResponse new
			subresponses: {aDbResponse.
					aPostResponse.
					aRenderedPostResponse.
					aPublishPostResponse}.

	self addResponse: aResponse.
	^ aResponse
]

{ #category : #accessing }
LeClientRenderedPostOfPagePublisher >> page [
	<return: #LePage>
	^ page
]

{ #category : #accessing }
LeClientRenderedPostOfPagePublisher >> page: aLePage [
	page := aLePage
]

{ #category : #accessing }
LeClientRenderedPostOfPagePublisher >> post [
	^ post
]

{ #category : #accessing }
LeClientRenderedPostOfPagePublisher >> post: anObject [
	post := anObject
]

{ #category : #'api - convenience' }
LeClientRenderedPostOfPagePublisher >> postFromPage: aPage [
	self page: aPage.
	self post: (LeClientPost forPage: aPage)
]

{ #category : #'api - actions' }
LeClientRenderedPostOfPagePublisher >> prepare [
	databaseCommand
		context: self context;
		prepare.
	postPublisher := LeClientPostPublisher new
			context: self context;
			post: post;
			page: page;
			prepare.
	renderedPost := LeClientRenderedPostPublisher new
			context: self context;
			post: post;
			page: page;
			prepare.
	publishPost := LeClientApiPublishPost new
			context: self context;
			post: post;
			authorName: authorName;
			prepare
]
