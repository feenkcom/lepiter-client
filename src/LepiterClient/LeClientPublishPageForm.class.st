Class {
	#name : #LeClientPublishPageForm,
	#superclass : #Object,
	#instVars : [
		'page',
		'client',
		'database',
		'author',
		'abstract',
		'title',
		'onPublish',
		'publishCommand',
		'pageExists'
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
LeClientPublishPageForm >> acceptLabel [
	^ self isExistingPage ifTrue: [ 'Republish existing page' ] ifFalse: [ 'Publish new page' ]
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
LeClientPublishPageForm >> isExistingPage [
	^ pageExists ifNil: [ pageExists := (self client findPostByPage: self page) isSuccess ]
]

{ #category : #accessing }
LeClientPublishPageForm >> magritteAcceptAction [
	<magritteActionDescription>
	^ super magritteAcceptAction
		label: self acceptLabel;
		isLabelVisible: true;
		onSuccessCallback: (GtMagritteCallback new
				action: [ :aModel :aButton :aMemento :aDescription | 
					self publish.
					self onPublish ifNotNil: [ :aBlock | aBlock value: publishCommand ] ]);
		onOverallStatusChanged: (GtMagritteBasicAction new
				action: [ :aStatus :aButton :aMemento :aDescription | 
					| isEnabled isVisible |
					isVisible := publishCommand isNil or: [ publishCommand isSuccess ].
					isEnabled := aStatus isValidAndInactive and: [ isVisible ].
					aDescription visible: isVisible.
					aDescription enabled: isEnabled ])
]

{ #category : #accessing }
LeClientPublishPageForm >> magritteCancelAction [
	"Users do not need a cancel action since all Magritte descriptions 
	have `#autoAccept:` set to true."
	<magritteActionDescription>
	^ nil
]

{ #category : #accessing }
LeClientPublishPageForm >> magritteRetryAction [
	<magritteActionDescription>
	^ MAActionDescription new
		priority: 11;
		label: 'Retry';
		isLabelVisible: true;
		blocIcon: BrGlamorousVectorIcons refresh;
		action: (GtMagritteAction new
				beInFutureProcess;
				beWithFutureResponse;
				action: [ :aModel :aButton :aMemento :aDescription | aMemento commit ]);
		beEnabledAndChangedAndValidAndInactiveOverallStatus;
		beToolbarAction;
		onSuccessCallback: (GtMagritteCallback new
				action: [ :aModel :aButton :aMemento :aDescription | 
					self retry.
					self onPublish ifNotNil: [ :aBlock | aBlock value: publishCommand ] ]);
		onOverallStatusChanged: (GtMagritteBasicAction new
				action: [ :aStatus :aButton :aMemento :aDescription | 
					| isEnabled isVisible |
					isVisible := (publishCommand isNotNil and: [ publishCommand isSuccess not ]).
					isEnabled := aStatus isValidAndInactive and: [ isVisible ].
					aDescription visible: isVisible.
					aDescription enabled: isEnabled ])
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
	| aCommand |
	publishCommand := aCommand := self client
				publishPostOfPage: self page
				inDatabaseNamed: self database
				authorName: self author.

	publishCommand isSuccess
		ifFalse: [ LeClientRequestError new
				client: self client;
				result: aCommand;
				signal ]
]

{ #category : #accessing }
LeClientPublishPageForm >> result [
	<return: #LeClientRenderedPostOfPagePublisher>
	^ publishCommand
]

{ #category : #actions }
LeClientPublishPageForm >> retry [
	"If the publishing was not successful, try it again"

	self assert: [ publishCommand isNotNil ] description: [ 'Result must be non-nil' ].
	publishCommand isSuccess ifTrue: [ ^ self ].

	publishCommand execute.

	publishCommand isSuccess
		ifFalse: [ LeClientRequestError new
				client: self client;
				result: publishCommand;
				signal ]
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
