Class {
	#name : #LeClientRenderedPostOfPagePublisher,
	#superclass : #LeClientCommand,
	#instVars : [
		'databaseCommand',
		'page',
		'postPublisher',
		'post'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientRenderedPostOfPagePublisher >> commands [
	^ LeClientUtility
		collectionWithoutNilItemsFrom: {databaseCommand.
				postPublisher}
]

{ #category : #accessing }
LeClientRenderedPostOfPagePublisher >> databaseName: aDatabaseName [
	databaseCommand := LeClientDatabaseNameSearcher new
			context: self context;
			databaseName: aDatabaseName
]

{ #category : #'api - actions' }
LeClientRenderedPostOfPagePublisher >> execute [
	| aDbResponse aPostResponse |
	self
		ifSuccess: [ :aPreviousResponse | ^ aPreviousResponse ]
		ifFailure: [  "repeat" ]
		ifNone: [  "execute" ].

	aDbResponse := databaseCommand execute.

	aPostResponse := aDbResponse
			ifSuccess: [ postPublisher
					serverDatabaseId: aDbResponse databaseId;
					execute ]
			ifFailure: [ LeClientCannotExecute new subresponse: aDbResponse ]
			ifNone: [ LeClientCannotExecute new subresponse: aDbResponse ].

	self addResponse: aPostResponse.
	^ aPostResponse
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
		prepare
]
