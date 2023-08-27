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
		'client',
		'post',
		'author'
	],
	#category : #'LepiterClient-UI'
}

{ #category : #accessing }
GtApPublishPostForm >> abstract [
	^ self post abstract
]

{ #category : #accessing }
GtApPublishPostForm >> abstract: aString [
	^ self post abstract: aString
]

{ #category : #accessing }
GtApPublishPostForm >> abstractDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Abstract';
		accessor: #abstract;
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
					self anchor phlow spawnObject: self post.
					self anchor
						inUIProcessDo: [ self anchor dispatchEvent: BrDropdownHideWish new ] ]);
		beEnabledOnValidAndInactiveOverallStatus
]

{ #category : #accessing }
GtApPublishPostForm >> page [
	^ page
]

{ #category : #accessing }
GtApPublishPostForm >> page: anObject [
	page := anObject.
	self post: (GtApServerPost forPage: page)
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
		priority: 4;
		beRequired
]

{ #category : #accessing }
GtApPublishPostForm >> post [
	^ post
]

{ #category : #accessing }
GtApPublishPostForm >> post: anObject [
	post := anObject
]

{ #category : #actions }
GtApPublishPostForm >> publish [
	| aPageResponse serverDatabase aFilePath aPostResponse |
	self halt.

	client := GtApLepiterClient new
			server: server;
			username: username;
			password: password;
			login.
	serverDatabase := client lookupDatabase: self database.
	self halt.
	aPageResponse := client
			exportPage: self page
			inDatabase: serverDatabase lepiterDatabase.
	self halt.
	aPostResponse := client
			createPost: self post
			forPage: self page
			inDatabase: serverDatabase lepiterDatabase asString.
	self post: aPostResponse model.
	self post
		database: self page database;
		serverDatabase: serverDatabase rawData.
	self halt.
	aFilePath := client createRenderedPost: self post.
	self halt.
	self
		post: (client
				publishPost: self post
				withAuthor: self author
				andFile: aFilePath)
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
		priority: 1;
		beRequired
]

{ #category : #accessing }
GtApPublishPostForm >> title [
	^ self post title
]

{ #category : #accessing }
GtApPublishPostForm >> title: aString [
	^ self post title: aString
]

{ #category : #accessing }
GtApPublishPostForm >> titleDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Title';
		accessor: #title;
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
		priority: 3;
		beRequired
]
