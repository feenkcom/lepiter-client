Class {
	#name : #LeClient,
	#superclass : #Object,
	#instVars : [
		'context'
	],
	#category : #'LepiterClient-Client New'
}

{ #category : #'api - configuration' }
LeClient >> context [
	<return: #LeClientContext>
	^ context ifNil: [ context := self defaultContext ]
]

{ #category : #'api - configuration' }
LeClient >> context: aContext [
	context := aContext
]

{ #category : #'api - actions' }
LeClient >> createPost: aPost forPage: aPage inDatabase: aDatabaseId [
	"It creates or updates a post. It also create or update the given page."

	<return: #TLeClientCommand>
	^ LeClientPostPublisher new
		context: self context;
		post: aPost;
		page: aPage;
		serverDatabaseId: aDatabaseId asString;
		prepare;
		execute;
		yourself
]

{ #category : #'api - actions' }
LeClient >> createRenderedPost: aClientPost page: aLePage [
	<return: #TLeClientCommand>
	^ LeClientRenderedPostPublisher new
		context: self context;
		post: aClientPost;
		page: aLePage;
		prepare;
		execute;
		yourself
]

{ #category : #'api - actions' }
LeClient >> databases [
	| aResponse |
	aResponse := LeClientApiDatabases new
			context: self context;
			prepare;
			execute.
	^ aResponse
		ifSuccess: #model
		ifFailure: [ #() ]
		ifNone: [ #() ]
]

{ #category : #initialization }
LeClient >> defaultContext [
	^ LeClientContext new serverUrl: LeClientEndpoints serverUrl
]

{ #category : #'api - actions' }
LeClient >> deleteAttachment: anAttachment fromDatabase: aDb [
	<return: #TLeClientCommand>
	^ LeClientApiDeleteAttachment new
		context: self context;
		snippetAttachment: anAttachment;
		serverDatabaseId: aDb ledatabase asString;
		prepare;
		execute;
		yourself
]

{ #category : #'api - actions' }
LeClient >> deletePage: aPage [
	<return: #TLeClientCommand>
	^ LeClientApiDeletePage new
		context: self context;
		page: aPage;
		prepare;
		execute;
		yourself
]

{ #category : #'api - actions' }
LeClient >> deletePost: aPost [
	<return: #TLeClientCommand>
	^ LeClientApiDeletePost new
		context: self context;
		post: aPost;
		prepare;
		execute;
		yourself
]

{ #category : #'api - actions' }
LeClient >> exportPage: aPage inDatabase: aDatabaseId [
	<return: #TLeClientCommand>
	^ LeClientPagePublisher new
		context: self context;
		page: aPage;
		serverDatabaseId: aDatabaseId asString;
		prepare;
		execute;
		yourself
]

{ #category : #'api - actions' }
LeClient >> findPostByPage: aPage [
	<return: #TLeClientCommand>
	^ LeClientApiPostByPage new
		context: context;
		page: aPage;
		prepare;
		execute;
		yourself
]

{ #category : #'api - actions' }
LeClient >> getPostForPage: aPage [
	<return: #TLeClientCommand>
	^ LeClientApiPostByPage new
		context: self context;
		page: aPage;
		prepare;
		execute;
		yourself
]

{ #category : #'gt - extensions' }
LeClient >> gtDatabasesFor: aView [
	<gtView>
	self token ifNil: [ ^ aView empty ].

	^ aView columnedList
		priority: 1;
		title: 'Databases';
		items: [ self databases ];
		column: 'Name' text: #name;
		column: 'Description' text: #description weight: 2;
		column: 'Location' text: #location
]

{ #category : #'api - actions' }
LeClient >> login [
	<return: #TLeClientCommand>
	^ LeClientApiLoginUser new
		context: self context;
		prepare;
		execute;
		yourself
]

{ #category : #'api - actions' }
LeClient >> lookupDatabase: aDbName [
	^ self databases detect: [ :aDb | aDb name = aDbName ]
]

{ #category : #'api - configuration' }
LeClient >> password: anUrl [
	self context password: anUrl
]

{ #category : #'api - actions' }
LeClient >> publishPostOfPage: aPage inDatabaseNamed: aDatabaseName authorName: anAuthorName [
	| aServerDatabase aPageResponse aPostResponse anInputPost anOutputPost aRenderedPostResponse |
	aServerDatabase := self lookupDatabase: aDatabaseName.

	aPageResponse := self
			exportPage: aPage
			inDatabase: aServerDatabase lepiterDatabase.
	aPageResponse isSuccess ifFalse: [ ^ aPageResponse ].

	anInputPost := LeClientPost forPage: aPage.
	aPostResponse := self getPostForPage: aPage.
	aPostResponse := self
			createPost: anInputPost
			forPage: aPage
			inDatabase: aServerDatabase lepiterDatabase asString.
	aPostResponse isSuccess ifFalse: [ ^ aPostResponse ].	"I think it should not be a rawData and the #createPost:forPage:inDatabase:
	must return properly initialized object."
	anOutputPost := aPostResponse model.
	anOutputPost serverDatabase: aServerDatabase.

	aRenderedPostResponse := self createRenderedPost: anOutputPost page: aPage.
	aRenderedPostResponse isSuccess ifFalse: [ ^ aRenderedPostResponse ].

	^ self
		publishPost: anOutputPost
		withAuthor: anAuthorName
		andFile: aRenderedPostResponse filePath
]

{ #category : #'api - configuration' }
LeClient >> server: anUrl [
	self serverUrl: anUrl
]

{ #category : #'api - configuration' }
LeClient >> serverUrl: anUrl [
	self context serverUrl: anUrl
]

{ #category : #'api - accessing' }
LeClient >> token [
	^ self context token
]

{ #category : #'api - configuration' }
LeClient >> username: anUrl [
	self context username: anUrl
]
