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
	^ LeJsonV4 uniqueInstance
		deserialize: (ZnClient new beOneShot
				url: self server , '/api/createPost';
				entity: (ZnEntity
						json: (STONJSON
								toString: {'page' -> aPage uid asString.
										'database' -> databaseId.
										'title' -> aPost title.
										'abstract' -> aPost abstract} asDictionary));
				setBearerAuthentication: self token;
				post) readStream
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
	| aPost aPageResponse anAttachmentResponse |
	anAttachmentResponse := self attachmentPoster
		page: aPage;
		serverDatabaseId: aDatabaseId;
		post.
	
	aPageResponse := self pagePoster 
		page: aPage; 
		serverDatabaseId: aDatabaseId; 
		post.
		
	"aPageResponse isSuccess ifFalse: [ ^ aPageResponse ]."
	
	anAttachmentResponse isSuccess ifFalse: [ ^ nil ].
	
	aPost := aPageResponse post.
	
	^ aPost
]

{ #category : #accessing }
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

{ #category : #accessing }
GtApLepiterClient >> gtLoginFor: aView [
	<gtView>
	^ (super gtMagritteFor: aView)
		title: 'Login'
]

{ #category : #accessing }
GtApLepiterClient >> gtMagritteFor: aView [
	<gtView>
	^ aView empty
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
				action: [ :aModel :aButton :aMemento :aDescription | self login])
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
