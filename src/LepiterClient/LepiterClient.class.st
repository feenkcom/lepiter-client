Class {
	#name : #LepiterClient,
	#superclass : #Object,
	#instVars : [
		'context'
	],
	#category : #'LepiterClient-Client New'
}

{ #category : #initialization }
LepiterClient >> close [
	context ifNotNil: [ context close ]
]

{ #category : #'api - configuration' }
LepiterClient >> context [
	<return: #LeClientContext>
	^ context ifNil: [ context := self defaultContext ]
]

{ #category : #'api - configuration' }
LepiterClient >> context: aContext [
	context := aContext
]

{ #category : #'api - actions' }
LepiterClient >> createPost: aPost forPage: aPage inDatabase: aDatabaseId [
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
LepiterClient >> createRenderedPost: aClientPost page: aLePage [
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
LepiterClient >> databases [
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
LepiterClient >> defaultContext [
	^ LeClientContext new serverUrl: LeClientEndpoints serverUrl
]

{ #category : #'api - actions' }
LepiterClient >> deleteAttachment: anAttachment fromDatabase: aDb [
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
LepiterClient >> deletePage: aPage [
	<return: #TLeClientCommand>
	^ LeClientApiDeletePage new
		context: self context;
		page: aPage;
		prepare;
		execute;
		yourself
]

{ #category : #'api - actions' }
LepiterClient >> deletePost: aPost [
	<return: #TLeClientCommand>
	^ LeClientApiDeletePost new
		context: self context;
		post: aPost;
		prepare;
		execute;
		yourself
]

{ #category : #'api - actions' }
LepiterClient >> exportPage: aPage inDatabase: aDatabaseId [
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
LepiterClient >> findPostByPage: aPage [
	<return: #TLeClientCommand>
	^ LeClientApiPostByPage new
		context: context;
		page: aPage;
		prepare;
		execute;
		yourself
]

{ #category : #'api - actions' }
LepiterClient >> getPagesForOrganization: leClientOrganization [
	<return: #TLeClientCommand>
	^ LeClientApiPages new
		context: self context;
		organization: leClientOrganization;
		prepare;
		execute;
		yourself
]

{ #category : #'api - actions' }
LepiterClient >> getPostForPage: aPage [
	<return: #TLeClientCommand>
	^ LeClientApiPostByPage new
		context: self context;
		page: aPage;
		prepare;
		execute;
		yourself
]

{ #category : #'api - actions' }
LepiterClient >> getPostsForOrganization: leClientOrganization [
	<return: #TLeClientCommand>
	^ LeClientApiPosts new
		context: self context;
		organization: leClientOrganization;
		prepare;
		execute;
		yourself
]

{ #category : #'gt - extensions' }
LepiterClient >> gtOrganizationsFor: aView [
	<gtView>
	self token ifNil: [ ^ aView empty ].

	^ aView columnedList
		priority: 1;
		title: 'Organizations';
		items: [ self organizations ];
		column: 'Name' text: #name;
		column: 'Description' text: #description weight: 2;
		column: 'Location' text: #location;
		contextItemLabel: 'Browse organization' 
			action: [ :anElement :anOrg | WebBrowser openOn: anOrg location ]
]

{ #category : #'api - actions' }
LepiterClient >> login [
	<return: #TLeClientCommand>
	^ LeClientApiLoginUser new
		context: self context;
		prepare;
		execute;
		yourself
]

{ #category : #'api - actions' }
LepiterClient >> lookupDatabase: aDbName [
	^ self databases detect: [ :aDb | aDb name = aDbName ]
]

{ #category : #accessing }
LepiterClient >> organizations [
	^ self databases
]

{ #category : #'api - configuration' }
LepiterClient >> password: anUrl [
	self context password: anUrl
]

{ #category : #'api - actions' }
LepiterClient >> preparePublishPostOfPage: aPage inOrganizationNamed: aDatabaseName authorName: anAuthorName [
	^ LeClientRenderedPostOfPagePublisher new
		context: (self context
			postAuthorName: anAuthorName;
			postPublishDate: DateAndTime now);
		page: aPage;
		post: (LeClientPost forPage: aPage);
		databaseName: aDatabaseName;
		authorName: anAuthorName;
		prepare;
		yourself
]

{ #category : #printing }
LepiterClient >> printOn: stream [
	super printOn: stream.
	stream nextPut: $(.
	self context ifNotNil: [
		stream nextPutAll: context username; nextPutAll: ' @ '; print: context serverUrl.
		self context token ifNotNil: [ stream nextPutAll: ' with token' ] ].
	stream nextPut: $)
]

{ #category : #'api - actions' }
LepiterClient >> publishPost: aPost withAuthor: anAuthorName andFile: aFilePath [
	^ LeClientApiPublishPost new
		context: self context;
		post: aPost;
		authorName: anAuthorName;
		filePath: aFilePath;
		prepare;
		execute;
		yourself
]

{ #category : #'api - actions' }
LepiterClient >> publishPostOfPage: aPage inDatabaseNamed: aDatabaseName authorName: anAuthorName [
	| aCommand |
	aCommand := self
			preparePublishPostOfPage: aPage
			inOrganizationNamed: aDatabaseName
			authorName: anAuthorName.
	aCommand execute.
	^ aCommand
]

{ #category : #'api - configuration' }
LepiterClient >> server [
	<return: #ZnUrl>
	^ self context serverUrl
]

{ #category : #'api - configuration' }
LepiterClient >> server: anUrl [
	self serverUrl: anUrl
]

{ #category : #'api - configuration' }
LepiterClient >> serverUrl: anUrl [
	self context serverUrl: anUrl
]

{ #category : #'api - accessing' }
LepiterClient >> token [
	^ self context token
]

{ #category : #'api - configuration' }
LepiterClient >> username: anUrl [
	self context username: anUrl
]
