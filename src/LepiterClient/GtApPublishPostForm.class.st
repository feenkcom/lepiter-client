Class {
	#name : #GtApPublishPostForm,
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
GtApPublishPostForm class >> defaultAuthor [
	^ defaultAuthor ifNil: [ '' ]
]

{ #category : #accessing }
GtApPublishPostForm class >> defaultAuthor: anObject [
	defaultAuthor := anObject
]

{ #category : #accessing }
GtApPublishPostForm class >> defaultDatabase [
	^ defaultDatabase ifNil: [ '' ]
]

{ #category : #accessing }
GtApPublishPostForm class >> defaultDatabase: anObject [
	defaultDatabase := anObject
]

{ #category : #accessing }
GtApPublishPostForm class >> defaultServer [
	^ defaultServer ifNil: [ 'https://lepiter.io' ]
]

{ #category : #defaults }
GtApPublishPostForm class >> defaultServer: anObject [
	defaultServer := anObject
]

{ #category : #accessing }
GtApPublishPostForm class >> defaultUsername [
	^ defaultUsername ifNil: [ '' ]
]

{ #category : #accessing }
GtApPublishPostForm class >> defaultUsername: anObject [
	defaultUsername := anObject
]

{ #category : #accessing }
GtApPublishPostForm >> abstract [
	^ abstract
]

{ #category : #accessing }
GtApPublishPostForm >> abstract: aString [
	abstract := aString
]

{ #category : #accessing }
GtApPublishPostForm >> abstractDescription [
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
GtApPublishPostForm >> anchor [
	^ anchor
]

{ #category : #accessing }
GtApPublishPostForm >> anchor: anObject [
	anchor := anObject
]

{ #category : #accessing }
GtApPublishPostForm >> asElement [
	^ self asGtMagritteViewModel asElement margin: (BlInsets all: 8)
]

{ #category : #accessing }
GtApPublishPostForm >> author [
	^ author
]

{ #category : #accessing }
GtApPublishPostForm >> author: anObject [
	author := anObject.
	self class defaultAuthor: anObject
]

{ #category : #accessing }
GtApPublishPostForm >> authorDescription [
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
GtApPublishPostForm >> database [
	^ database
]

{ #category : #accessing }
GtApPublishPostForm >> database: anObject [
	database := anObject.
	self class defaultDatabase: anObject
]

{ #category : #accessing }
GtApPublishPostForm >> databaseDescription [
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
GtApPublishPostForm >> initialize [
	server := self class defaultServer.
	username := self class defaultUsername.
	password := ''.
	database := self class defaultDatabase.
	abstract := ''.
	author := self class defaultAuthor
]

{ #category : #accessing }
GtApPublishPostForm >> magritteAcceptAction [
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
GtApPublishPostForm >> magritteCancelAction [
	"Users do not need a cancel action since all Magritte descriptions 
	have `#autoAccept:` set to true."
	<magritteActionDescription>
	^ nil
]

{ #category : #accessing }
GtApPublishPostForm >> page [
	^ page
]

{ #category : #accessing }
GtApPublishPostForm >> page: aPage [
	| aPost |
	page := aPage.
	aPost := GtApServerPost forPage: aPage.
	self title: aPost title.
	self abstract: aPost abstract
]

{ #category : #accessing }
GtApPublishPostForm >> password [
	^ password
]

{ #category : #accessing }
GtApPublishPostForm >> password: anObject [
	password := anObject
]

{ #category : #accessing }
GtApPublishPostForm >> passwordDescription [
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
GtApPublishPostForm >> publish [
	| aClient aResult |
	aClient := GtApLepiterClient new
			server: server;
			username: username;
			password: password;
			login.

	result := aResult := aClient
			publishPostOfPage: self page
			inDatabaseNamed: self database
			authorName: self author.

	result isSuccess
		ifFalse: [ GtApLepiterRequestError new
				client: aClient;
				result: aResult;
				signal ]
]

{ #category : #accessing }
GtApPublishPostForm >> result [
	^ result
]

{ #category : #accessing }
GtApPublishPostForm >> server [
	^ server
]

{ #category : #accessing }
GtApPublishPostForm >> server: anObject [
	server := anObject.
	self class defaultServer: anObject
]

{ #category : #accessing }
GtApPublishPostForm >> serverDescription [
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
GtApPublishPostForm >> title [
	^ title
]

{ #category : #accessing }
GtApPublishPostForm >> title: aString [
	title := aString
]

{ #category : #accessing }
GtApPublishPostForm >> titleDescription [
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
GtApPublishPostForm >> username [
	^ username
]

{ #category : #accessing }
GtApPublishPostForm >> username: anObject [
	username := anObject.
	self class defaultUsername: anObject
]

{ #category : #accessing }
GtApPublishPostForm >> usernameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Username';
		accessor: #username;
		default: '';
		priority: 3;
		autoAccept: true;
		beRequired
]
