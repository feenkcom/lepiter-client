Class {
	#name : #LeClientPublishPostForm,
	#superclass : #Object,
	#instVars : [
		'page',
		'username',
		'password',
		'server',
		'anchor',
		'database',
		'author',
		'result',
		'abstract',
		'title'
	],
	#classInstVars : [
		'defaultServer',
		'defaultUsername',
		'defaultDatabase',
		'defaultAuthor'
	],
	#category : #'LepiterClient-UI'
}

{ #category : #accessing }
LeClientPublishPostForm class >> defaultAuthor [
	^ defaultAuthor ifNil: [ '' ]
]

{ #category : #accessing }
LeClientPublishPostForm class >> defaultAuthor: anObject [
	defaultAuthor := anObject
]

{ #category : #accessing }
LeClientPublishPostForm class >> defaultDatabase [
	^ defaultDatabase ifNil: [ '' ]
]

{ #category : #accessing }
LeClientPublishPostForm class >> defaultDatabase: anObject [
	defaultDatabase := anObject
]

{ #category : #accessing }
LeClientPublishPostForm class >> defaultServer [
	^ defaultServer ifNil: [ 'https://lepiter.io' ]
]

{ #category : #defaults }
LeClientPublishPostForm class >> defaultServer: anObject [
	defaultServer := anObject
]

{ #category : #accessing }
LeClientPublishPostForm class >> defaultUsername [
	^ defaultUsername ifNil: [ '' ]
]

{ #category : #accessing }
LeClientPublishPostForm class >> defaultUsername: anObject [
	defaultUsername := anObject
]

{ #category : #accessing }
LeClientPublishPostForm >> abstract [
	^ abstract
]

{ #category : #accessing }
LeClientPublishPostForm >> abstract: aString [
	abstract := aString
]

{ #category : #accessing }
LeClientPublishPostForm >> abstractDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Abstract';
		accessor: #abstract;
		default: '';
		priority: 6;
		autoAccept: true;
		beRequired
]

{ #category : #accessing }
LeClientPublishPostForm >> anchor [
	^ anchor
]

{ #category : #accessing }
LeClientPublishPostForm >> anchor: anObject [
	anchor := anObject
]

{ #category : #accessing }
LeClientPublishPostForm >> asElement [
	^ self asGtMagritteViewModel asElement margin: (BlInsets all: 8)
]

{ #category : #accessing }
LeClientPublishPostForm >> author [
	^ author
]

{ #category : #accessing }
LeClientPublishPostForm >> author: anObject [
	author := anObject.
	self class defaultAuthor: anObject
]

{ #category : #accessing }
LeClientPublishPostForm >> authorDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Author';
		accessor: #author;
		default: '';
		priority: 7;
		autoAccept: true;
		beRequired
]

{ #category : #accessing }
LeClientPublishPostForm >> database [
	^ database
]

{ #category : #accessing }
LeClientPublishPostForm >> database: anObject [
	database := anObject.
	self class defaultDatabase: anObject
]

{ #category : #accessing }
LeClientPublishPostForm >> databaseDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Database';
		accessor: #database;
		default: '';
		priority: 2;
		autoAccept: true;
		beRequired
]

{ #category : #accessing }
LeClientPublishPostForm >> initialize [
	server := self class defaultServer.
	username := self class defaultUsername.
	password := ''.
	database := self class defaultDatabase.
	abstract := ''.
	author := self class defaultAuthor
]

{ #category : #accessing }
LeClientPublishPostForm >> magritteAcceptAction [
	<magritteActionDescription>
	^ super magritteAcceptAction
		onSuccessCallback: (GtMagritteCallback new
				action: [ :aModel :aButton :aMemento :aDescription | 
					self publish.
					self anchor phlow spawnObject: self result.
					self anchor
						inUIProcessDo: [ self anchor dispatchEvent: BrDropdownHideWish new ] ]);
		beEnabledOnValidAndInactiveOverallStatus
]

{ #category : #accessing }
LeClientPublishPostForm >> magritteCancelAction [
	"Users do not need a cancel action since all Magritte descriptions 
	have `#autoAccept:` set to true."
	<magritteActionDescription>
	^ nil
]

{ #category : #accessing }
LeClientPublishPostForm >> page [
	^ page
]

{ #category : #accessing }
LeClientPublishPostForm >> page: aPage [
	| aPost |
	page := aPage.
	aPost := LeClientPost forPage: aPage.
	self title: aPost title.
	self abstract: aPost abstract
]

{ #category : #accessing }
LeClientPublishPostForm >> password [
	^ password
]

{ #category : #accessing }
LeClientPublishPostForm >> password: anObject [
	password := anObject
]

{ #category : #accessing }
LeClientPublishPostForm >> passwordDescription [
	<magritteDescription>
	^ MAPasswordDescription new
		label: 'Password';
		accessor: #password;
		default: '';
		priority: 4;
		autoAccept: true;
		beRequired
]

{ #category : #actions }
LeClientPublishPostForm >> publish [
	| aClient aResult |
	aClient := LepiterClient new
			server: server;
			username: username;
			password: password.
	result := aResult := aClient login
				ifSuccess: [ 
					| aCommand |
					aCommand := aClient
						publishPostOfPage: self page
						inDatabaseNamed: self database
						authorName: self author.
					aCommand lastResponse ]
				ifFailure: [ :aFailure | aFailure ]
				ifNone: [ LeClientNoResponse new ].

	aResult isSuccess
		ifFalse: [ LeClientRequestError new
				client: aClient;
				result: aResult;
				signal ]
]

{ #category : #accessing }
LeClientPublishPostForm >> result [
	^ result
]

{ #category : #accessing }
LeClientPublishPostForm >> server [
	^ server
]

{ #category : #accessing }
LeClientPublishPostForm >> server: anObject [
	server := anObject.
	self class defaultServer: anObject
]

{ #category : #accessing }
LeClientPublishPostForm >> serverDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Server';
		accessor: #server;
		default: '';
		priority: 1;
		autoAccept: true;
		beRequired
]

{ #category : #accessing }
LeClientPublishPostForm >> title [
	^ title
]

{ #category : #accessing }
LeClientPublishPostForm >> title: aString [
	title := aString
]

{ #category : #accessing }
LeClientPublishPostForm >> titleDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Title';
		accessor: #title;
		default: '';
		priority: 5;
		autoAccept: true;
		beRequired
]

{ #category : #accessing }
LeClientPublishPostForm >> username [
	^ username
]

{ #category : #accessing }
LeClientPublishPostForm >> username: anObject [
	username := anObject.
	self class defaultUsername: anObject
]

{ #category : #accessing }
LeClientPublishPostForm >> usernameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Username';
		accessor: #username;
		default: '';
		priority: 3;
		autoAccept: true;
		beRequired
]
