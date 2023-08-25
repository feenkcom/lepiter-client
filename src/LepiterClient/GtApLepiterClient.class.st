Class {
	#name : #GtApLepiterClient,
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
GtApLepiterClient >> attachmentPoster [
	^ GtApLepiterAttachmentPoster new client: self
]

{ #category : #accessing }
GtApLepiterClient >> createPost: aPost forPage: aPage inDatabase: databaseId [
	| aZnClient anEntity anApResponse aModel |
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

	anApResponse := GtApLepiterRequestUtility responseForZnClient: aZnClient.
	anApResponse isSuccess ifFalse: [ ^ anApResponse ].

	aModel := LeJsonV4 uniqueInstance deserialize: aZnClient response entity string readStream.
	anApResponse model: aModel.
	^ anApResponse
]

{ #category : #accessing }
GtApLepiterClient >> createRenderedPost: aPost [
	| postUuid postDirectory filePath figureCode |
	postUuid := aPost uuid.
	postDirectory := (FileLocator temp asFileReference / postUuid asString)
			ensureCreateDirectory.
	filePath := aPost publishTo: postDirectory usingPath: nil.
	figureCode := (postDirectory / 'gt-figures') exists
			ifTrue: [ ((postDirectory / 'gt-figures') children
					collect: [ :aFile | aFile basename -> aFile binaryContents asString ])
					asDictionary ]
			ifFalse: [ {} ].
	ZnClient new beOneShot
		url: self server, '/api/createRenderedPost';
		entity: (ZnEntity
				json: (STONJSON
						toString: {'post' -> postUuid asString.
								'filePath' -> filePath pathString.
								'contents'
									-> (postDirectory / filePath pathString) asFileReference contents.
								'figures' -> figureCode} asDictionary));
		setBearerAuthentication: token;
		post.
	^ filePath
]

{ #category : #accessing }
GtApLepiterClient >> databases [
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

{ #category : #'api - publishing' }
GtApLepiterClient >> exportPage: aPage inDatabase: aDatabaseId [
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
	
	^ GtApLepiterClientExportPageSuccessResponse new
		clientPage: aPage;
		serverDatabaseId: aDatabaseId;
		serverPage: aServerPage;
		responses: { anAttachmentResponse. aPageResponse }
]

{ #category : #'gt - extensions' }
GtApLepiterClient >> gtDatabasesFor: aView [
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
GtApLepiterClient >> gtMagritteFor: aView [
	<gtView>
	^ (super gtMagritteFor: aView) title: 'Login'
]

{ #category : #accessing }
GtApLepiterClient >> initialize [
	server := ''.
	username := ''.
	password := ''
]

{ #category : #accessing }
GtApLepiterClient >> login [
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
GtApLepiterClient >> lookupDatabase: aDbName [
	^ self databases detect: [:aDb | aDb name = aDbName ]
]

{ #category : #accessing }
GtApLepiterClient >> magritteAcceptAction [
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
GtApLepiterClient >> pagePoster [
	^ GtApLepiterPagePoster new client: self
]

{ #category : #accessing }
GtApLepiterClient >> password [
	^ password
]

{ #category : #accessing }
GtApLepiterClient >> password: anObject [
	password := anObject
]

{ #category : #accessing }
GtApLepiterClient >> passwordDescription [
	<magritteDescription>
	^ MAPasswordDescription new
		priority: 3;
		label: 'Password';
		accessor: #password
]

{ #category : #accessing }
GtApLepiterClient >> publishPost: aPost withAuthor: anAuthorName andFile: aFilePath [
	^ LeJsonV4 uniqueInstance
		deserialize: (ZnClient new beOneShot
				url: self server, '/api/publishPost';
				entity: (ZnEntity
						json: '{"post": "' , aPost uuid asString , '", "file": "' , aFilePath pathString
								, '", "author": "' , anAuthorName , '"}');
				setBearerAuthentication: token;
				post) readStream
]

{ #category : #accessing }
GtApLepiterClient >> server [
	^ server
]

{ #category : #accessing }
GtApLepiterClient >> server: anObject [
	server := anObject
]

{ #category : #accessing }
GtApLepiterClient >> serverDescription [
	<magritteDescription>
	^ MAStringDescription new
		priority: 1;
		label: 'Server';
		accessor: #server
]

{ #category : #accessing }
GtApLepiterClient >> token [
	^ token
]

{ #category : #accessing }
GtApLepiterClient >> token: anObject [
	token := anObject
]

{ #category : #accessing }
GtApLepiterClient >> username [
	^ username
]

{ #category : #accessing }
GtApLepiterClient >> username: anObject [
	username := anObject
]

{ #category : #accessing }
GtApLepiterClient >> usernameDescription [
	<magritteDescription>
	^ MAStringDescription new
		priority: 2;
		label: 'Username';
		accessor: #username
]
