Class {
	#name : #LeClientPublishPageForm,
	#superclass : #Object,
	#instVars : [
		'page',
		'client',
		'database',
		'author',
		'result',
		'abstract',
		'title',
		'onPublish'
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
LeClientPublishPageForm class >> defaultAuthor [
	^ defaultAuthor ifNil: [ '' ]
]

{ #category : #accessing }
LeClientPublishPageForm class >> defaultAuthor: anObject [
	defaultAuthor := anObject
]

{ #category : #accessing }
LeClientPublishPageForm class >> defaultDatabase [
	^ defaultDatabase ifNil: [ '' ]
]

{ #category : #accessing }
LeClientPublishPageForm class >> defaultDatabase: anObject [
	defaultDatabase := anObject
]

{ #category : #accessing }
LeClientPublishPageForm class >> defaultServer [
	^ defaultServer ifNil: [ 'https://lepiter.io' ]
]

{ #category : #defaults }
LeClientPublishPageForm class >> defaultServer: anObject [
	defaultServer := anObject
]

{ #category : #accessing }
LeClientPublishPageForm class >> defaultUsername [
	^ defaultUsername ifNil: [ '' ]
]

{ #category : #accessing }
LeClientPublishPageForm class >> defaultUsername: anObject [
	defaultUsername := anObject
]

{ #category : #accessing }
LeClientPublishPageForm >> abstract [
	^ abstract
]

{ #category : #accessing }
LeClientPublishPageForm >> abstract: aString [
	abstract := aString
]

{ #category : #accessing }
LeClientPublishPageForm >> abstractDescription [
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
LeClientPublishPageForm >> author [
	^ author
]

{ #category : #accessing }
LeClientPublishPageForm >> author: anObject [
	author := anObject.
	self class defaultAuthor: anObject
]

{ #category : #accessing }
LeClientPublishPageForm >> authorDescription [
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
LeClientPublishPageForm >> client [
	^ client
]

{ #category : #accessing }
LeClientPublishPageForm >> client: anObject [
	client := anObject
]

{ #category : #accessing }
LeClientPublishPageForm >> database [
	^ database
]

{ #category : #accessing }
LeClientPublishPageForm >> database: anObject [
	database := anObject.
	self class defaultDatabase: anObject
]

{ #category : #accessing }
LeClientPublishPageForm >> databaseDescription [
	<magritteDescription>
	^ MASingleOptionDescription new
		label: 'Database';
		accessor: #database;
		default: '';
		priority: 2;
		autoAccept: true;
		options: (self client databases collect: #name);
		beRequired
]

{ #category : #accessing }
LeClientPublishPageForm >> initialize [
	database := self class defaultDatabase.
	abstract := ''.
	author := self class defaultAuthor
]

{ #category : #accessing }
LeClientPublishPageForm >> magritteAcceptAction [
	<magritteActionDescription>
	^ super magritteAcceptAction
		onSuccessCallback: (GtMagritteCallback new
				action: [ :aModel :aButton :aMemento :aDescription | 
					self publish.
					self onPublish ifNotNil: [ :aBlock | aBlock value: result ] ]);
		beEnabledOnValidAndInactiveOverallStatus
]

{ #category : #accessing }
LeClientPublishPageForm >> magritteCancelAction [
	"Users do not need a cancel action since all Magritte descriptions 
	have `#autoAccept:` set to true."
	<magritteActionDescription>
	^ nil
]

{ #category : #accessing }
LeClientPublishPageForm >> onPublish [
	^ onPublish
]

{ #category : #accessing }
LeClientPublishPageForm >> onPublish: anObject [
	onPublish := anObject
]

{ #category : #accessing }
LeClientPublishPageForm >> page [
	^ page
]

{ #category : #accessing }
LeClientPublishPageForm >> page: aPage [
	| aPost |
	page := aPage.
	aPost := LeClientPost forPage: aPage.
	self title: aPost title.
	self abstract: aPost abstract
]

{ #category : #actions }
LeClientPublishPageForm >> publish [
	| aResult |
	result := aResult := self client
				publishPostOfPage: self page
				inDatabaseNamed: self database
				authorName: self author.

	result isSuccess
		ifFalse: [ LeClientRequestError new
				client: self client;
				result: aResult;
				signal ]
]

{ #category : #accessing }
LeClientPublishPageForm >> result [
	^ result
]

{ #category : #accessing }
LeClientPublishPageForm >> title [
	^ title
]

{ #category : #accessing }
LeClientPublishPageForm >> title: aString [
	title := aString
]

{ #category : #accessing }
LeClientPublishPageForm >> titleDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Title';
		accessor: #title;
		default: '';
		priority: 5;
		autoAccept: true;
		beRequired
]
