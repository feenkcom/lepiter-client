Class {
	#name : #LepiterOldClient,
	#superclass : #Object,
	#instVars : [
		'server',
		'username',
		'password',
		'token'
	],
	#category : #'LepiterClient-Client'
}

{ #category : #'private - publishing' }
LepiterOldClient >> attachmentPoster [
	^ LeClientAttachmentPoster new client: self
]

{ #category : #accessing }
LepiterOldClient >> createPost: aPost forPage: aPage inDatabase: databaseId [
	| aZnClient anEntity anApResponse aServerPost |
	anEntity := ZnEntity
			json: (STONJSON
					toString: {'page' -> aPage uid asString.
							'database' -> databaseId asString.
							'title' -> aPost title.
							'abstract' -> aPost abstract} asDictionary).
	aZnClient := ZnClient new beOneShot
			url: self server , '/api/createPost';
			entity: anEntity;
			setBearerAuthentication: self token.
	aZnClient post.

	anApResponse := LeClientRequestUtility responseForZnClient: aZnClient.
	anApResponse isSuccess ifFalse: [ ^ anApResponse ].

	aServerPost := LeJsonV4 uniqueInstance deserialize: aZnClient response entity string readStream.
	
	anApResponse model: aServerPost.
	^ anApResponse
]

{ #category : #accessing }
LepiterOldClient >> createRenderedPost: aServerPost page: aLePage [
	| postUuid postDirectory filePath figureCode anEntity aClient aResponse anApResponse basename |
	postUuid := aServerPost uuid.
	postDirectory := (FileLocator temp asFileReference
			/ ('lepiter-client-post-directory-' , postUuid asString))
			ensureCreateDirectory.
	filePath := aServerPost publishTo: postDirectory usingPath: nil.
	basename := filePath basenameWithoutExtension.
	figureCode := self exportFigures: postDirectory.

	figureCode := figureCode
			collect: [ :aPair | 
				aPair value isSuccess
					ifTrue: [ | aJson |
						aJson := NeoJSONObject fromString: aPair value response contents.
						aPair key -> (aJson at: #blob) ]
					ifFalse: [ ^ aPair value ] ].

	anEntity := ZnEntity
			json: (STONJSON
					toString: {'post' -> postUuid asString.
							'filePath' -> basename.
							'contents'
								-> (postDirectory / filePath pathString) asFileReference contents.
							'figures' -> figureCode asDictionary} asDictionary).

	aClient := ZnClient new beOneShot
			url: self server , '/api/createRenderedPost';
			entity: anEntity;
			setBearerAuthentication: token.

	aResponse := aClient
			post;
			response.

	anApResponse := LeClientRequestUtility responseForZnClient: aClient.

	anApResponse isSuccess
		ifTrue: [ | aModel |
			aModel := LeJsonV4 uniqueInstance
					deserialize: aResponse entity string readStream.
			anApResponse model: aModel ].

	^ LeClientCreateRenderedPostResponse new
		response: anApResponse;
		filePath: basename asFileReference asPath;
		serverPost: aServerPost
]

{ #category : #accessing }
LepiterOldClient >> databases [
	| allDatabases |
	allDatabases := LeJsonV4 uniqueInstance
		deserialize: (ZnClient new beOneShot
				url: self server , '/api/databases';
				setBearerAuthentication: self token;
				get;
				response) entity string readStream.
				
	allDatabases do: [ :aDatabase | 
		aDatabase 
			server: self server; 
			token: self token ].
			
	^ allDatabases
]

{ #category : #accessing }
LepiterOldClient >> deleteAttachment: anAttachment fromDatabase: aDb [
	| aClient aResponse |
	aClient := ZnClient new beOneShot
			url: self server , '/api/deleteAttachment';
			entity: (ZnEntity
					json: '{"attachment": "' , anAttachment uidString , '", "database": "'
							, aDb ledatabase asString , '"}');
			setBearerAuthentication: token.

	aResponse := aClient
			post;
			response.

	^ LeClientRequestUtility responseForZnClient: aClient
]

{ #category : #accessing }
LepiterOldClient >> deletePage: aPage [
	| aClient aResponse |
	aClient := ZnClient new beOneShot
			url: self server , '/api/deletePage';
			entity: (ZnEntity json: '{"page": "' , aPage uid asString36 , '"}');
			setBearerAuthentication: token.

	aResponse := aClient
			post;
			response.

	^ LeClientRequestUtility responseForZnClient: aClient
]

{ #category : #accessing }
LepiterOldClient >> deletePost: aPost [
	| aClient aResponse |
	aClient := ZnClient new beOneShot
			url: self server , '/api/deletePost';
			entity: (ZnEntity json: '{"post": "' , aPost uuid asString , '"}');
			setBearerAuthentication: token.

	aResponse := aClient
			post;
			response.

	^ LeClientRequestUtility responseForZnClient: aClient
]

{ #category : #accessing }
LepiterOldClient >> exportFigure: aFile [ 
	^ aFile basename -> (self exportFile: aFile)
]

{ #category : #accessing }
LepiterOldClient >> exportFigures: postDirectory [
	^ (postDirectory / 'gt-figures') exists
		ifTrue: [ (postDirectory / 'gt-figures') children
				collect: [ :aFile | self exportFigure: aFile ] ]
		ifFalse: [ {} ]
]

{ #category : #accessing }
LepiterOldClient >> exportFile: aFile [
	| aClient aZnResponse anApResponse |
	aClient := ZnClient new beOneShot
			url: self server , '/api/createFile';
			entity: (ZnEntity bytes: aFile binaryContents);
			setBearerAuthentication: self token.

	aZnResponse := aClient
			post;
			response.

	anApResponse := LeClientRequestUtility responseForZnClient: aClient.

	^ anApResponse
]

{ #category : #'api - publishing' }
LepiterOldClient >> exportPage: aPage inDatabase: aDatabaseId [
	| aServerPage aPageResponse anAttachmentResponse |
	anAttachmentResponse := self attachmentPoster
		page: aPage;
		serverDatabaseId: aDatabaseId;
		post.
		
	anAttachmentResponse isSuccess ifFalse: [ ^ anAttachmentResponse ].
	
	aPageResponse := self pagePoster 
		page: aPage; 
		serverDatabaseId: aDatabaseId; 
		post.
		
	aPageResponse isSuccess ifFalse: [ ^ aPageResponse ].
	
	aServerPage := aPageResponse serverPage.
	
	^ LeClientClientExportPageSuccessResponse new
		clientPage: aPage;
		serverDatabaseId: aDatabaseId;
		serverPage: aServerPage;
		responses: { anAttachmentResponse. aPageResponse }
]

{ #category : #accessing }
LepiterOldClient >> findPostByPage: aPage [
	| aClient aResponse anApResponse |
	aClient := ZnClient new beOneShot
			url: self server , '/api/postByPage';
			queryAt: 'page' put:  aPage uid asString36;
			setBearerAuthentication: token.

	aResponse := aClient
			get;
			response.
			
	anApResponse := LeClientRequestUtility responseForZnClient: aClient.

	anApResponse isSuccess ifTrue: [ 
		| aServerPost |
		aServerPost := LeJsonV4 uniqueInstance deserialize: aResponse contents readStream.
		anApResponse model: aServerPost ].
		
	^ anApResponse
]

{ #category : #accessing }
LepiterOldClient >> getPostForPage: aPage [
	| aZnClient |
	aZnClient := ZnClient new beOneShot
			url: self server , '/api/postByPage';
			queryAt: 'page' put: aPage uid;
			setBearerAuthentication: self token.

	aZnClient get.

	^ LeClientRequestUtility responseForZnClient: aZnClient
]

{ #category : #'gt - extensions' }
LepiterOldClient >> gtDatabasesFor: aView [
	<gtView>
	self token ifNil: [ ^ aView empty ].

	^ aView columnedList
		priority: 1;
		title: 'Databases';
		items: [ self databases ];
		column: 'Name' text: #name;
		column: 'Description' text: #description;
		column: 'Location' text: #location
]

{ #category : #'gt - extensions' }
LepiterOldClient >> gtMagritteFor: aView [
	<gtView>
	^ (super gtMagritteFor: aView) title: 'Login'
]

{ #category : #accessing }
LepiterOldClient >> initialize [
	server := ''.
	username := ''.
	password := ''
]

{ #category : #accessing }
LepiterOldClient >> login [
	| loginResult response data |
	data := ZnEntity
			json: (STONJSON
					toString: {'username' -> self username.
							'password' -> self password} asDictionary).
	response := ZnEasy post: self server , '/api/loginUser' data: data.

	response isSuccess ifFalse: [ 
		self error: ('Unsuccessful login: {1}' 
			format: {response}) ].

	loginResult := STONJSON fromString: response entity string.
	self token: (loginResult at: 'token')
]

{ #category : #accessing }
LepiterOldClient >> lookupDatabase: aDbName [
	^ self databases detect: [:aDb | aDb name = aDbName ]
]

{ #category : #accessing }
LepiterOldClient >> magritteAcceptAction [
	<magritteActionDescription>
	^ super magritteAcceptAction
		onSuccessCallback: (GtMagritteCallback new
				action: [ :aModel :aButton :aMemento :aDescription | 
					aMemento commit. 
					self login.
					aButton phlow fireUpdateWish ]);
		beEnabledOnValidAndInactiveOverallStatus
]

{ #category : #'private - publishing' }
LepiterOldClient >> pagePoster [
	^ LeClientPagePoster new client: self
]

{ #category : #accessing }
LepiterOldClient >> password [
	^ password
]

{ #category : #accessing }
LepiterOldClient >> password: anObject [
	password := anObject
]

{ #category : #accessing }
LepiterOldClient >> passwordDescription [
	<magritteDescription>
	^ MAPasswordDescription new
		priority: 3;
		label: 'Password';
		accessor: #password
]

{ #category : #accessing }
LepiterOldClient >> publishPost: aPost withAuthor: anAuthorName andFile: aFilePath [
	| anEntity aClient aResponse anApResponse |
	anEntity := ZnEntity
			json: '{"post": "' , aPost uuid asString , '", "file": "' , aFilePath pathString
					, '", "author": "' , anAuthorName , '"}'.
	aClient := ZnClient new beOneShot
			url: self server , '/api/publishPost';
			entity: anEntity;
			setBearerAuthentication: token.

	aResponse := aClient
			post;
			response.
			
	anApResponse := LeClientRequestUtility responseForZnClient: aClient.

	anApResponse isSuccess ifTrue: [ 
		| aServerPost |
		aServerPost := LeJsonV4 uniqueInstance deserialize: aResponse contents readStream.
		anApResponse model: aServerPost ].
		
	^ LeClientPublishPostResponse new
		inputPost: aPost;
		authorName: anAuthorName;
		filePath: aFilePath;
		response: anApResponse
]

{ #category : #accessing }
LepiterOldClient >> publishPostOfPage: aPage inDatabaseNamed: aDatabaseName authorName: anAuthorName [
	| aServerDatabase aPageResponse aPostResponse anInputPost anOutputPost aRenderedPostResponse |
	aServerDatabase := self lookupDatabase: aDatabaseName.

	aPageResponse := self
			exportPage: aPage
			inDatabase: aServerDatabase lepiterDatabase.
	aPageResponse isSuccess ifFalse: [ ^ aPageResponse ].

	anInputPost := LeClientPost forPage: aPage.
	aPostResponse := self getPostForPage: aPage.
	aPostResponse := aPostResponse isSuccess
			ifTrue: [ self
					updatePost: anInputPost
					forPage: aPage
					inDatabase: aServerDatabase lepiterDatabase asString ]
			ifFalse: [ self
					createPost: anInputPost
					forPage: aPage
					inDatabase: aServerDatabase lepiterDatabase asString ].
	aPostResponse isSuccess ifFalse: [ ^ aPostResponse ].	
	
	"I think it should not be a rawData and the #createPost:forPage:inDatabase:
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

{ #category : #accessing }
LepiterOldClient >> server [
	^ server
]

{ #category : #accessing }
LepiterOldClient >> server: anObject [
	server := anObject
]

{ #category : #accessing }
LepiterOldClient >> serverDescription [
	<magritteDescription>
	^ MAStringDescription new
		priority: 1;
		label: 'Server';
		accessor: #server
]

{ #category : #accessing }
LepiterOldClient >> token [
	^ token
]

{ #category : #accessing }
LepiterOldClient >> token: anObject [
	token := anObject
]

{ #category : #accessing }
LepiterOldClient >> updatePost: aPost forPage: aPage inDatabase: databaseId [
	| aZnClient anEntity anApResponse aServerPost |
	anEntity := ZnEntity
			json: (STONJSON
					toString: {'page' -> aPage uid asString.
							'database' -> databaseId asString.
							'title' -> aPost title.
							'abstract' -> aPost abstract} asDictionary).
	aZnClient := ZnClient new beOneShot
			url: self server , '/api/updatePost';
			entity: anEntity;
			setBearerAuthentication: self token.
	aZnClient post.

	anApResponse := LeClientRequestUtility responseForZnClient: aZnClient.
	anApResponse isSuccess ifFalse: [ ^ anApResponse ].

	aServerPost := LeJsonV4 uniqueInstance
			deserialize: aZnClient response entity string readStream.
	aServerPost database: aPage database.

	anApResponse model: aServerPost.
	^ anApResponse
]

{ #category : #accessing }
LepiterOldClient >> username [
	^ username
]

{ #category : #accessing }
LepiterOldClient >> username: anObject [
	username := anObject
]

{ #category : #accessing }
LepiterOldClient >> usernameDescription [
	<magritteDescription>
	^ MAStringDescription new
		priority: 2;
		label: 'Username';
		accessor: #username
]
