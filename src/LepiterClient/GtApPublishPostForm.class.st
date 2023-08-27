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
	#category : #'LepiterClient-UI'
}

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
	author := anObject
]

{ #category : #accessing }
GtApPublishPostForm >> authorDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Author';
		accessor: #author;
		default: '';
		priority: 7;
		beRequired
]

{ #category : #accessing }
GtApPublishPostForm >> database [
	^ database
]

{ #category : #accessing }
GtApPublishPostForm >> database: anObject [
	database := anObject
]

{ #category : #accessing }
GtApPublishPostForm >> databaseDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Database';
		accessor: #database;
		default: '';
		priority: 2;
		beRequired
]

{ #category : #accessing }
GtApPublishPostForm >> defaultServer [
	^ 'https://test.lepiter.io'
]

{ #category : #accessing }
GtApPublishPostForm >> initialize [
	server := self defaultServer.
	username := ''.
	password := ''.
	database := ''.
	author := ''
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
	server := anObject
]

{ #category : #accessing }
GtApPublishPostForm >> serverDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Server';
		accessor: #server;
		default: '';
		priority: 1;
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
		beRequired
]

{ #category : #accessing }
GtApPublishPostForm >> username [
	^ username
]

{ #category : #accessing }
GtApPublishPostForm >> username: anObject [
	username := anObject
]

{ #category : #accessing }
GtApPublishPostForm >> usernameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Username';
		accessor: #username;
		default: '';
		priority: 3;
		beRequired
]
