Class {
	#name : #GtApLepiterDatabasePane,
	#superclass : #BrVerticalPane,
	#instVars : [
		'server',
		'token',
		'databaseList',
		'databases',
		'databaseDetails',
		'pages',
		'posts',
		'database'
	],
	#category : #'LepiterClient-UI'
}

{ #category : #accessing }
GtApLepiterDatabasePane >> initialize [
	super initialize.
	
	self initializeDatabaseList.
	self initializeDatabaseDetails.
	
	self addChild: databaseList as: #databases.
	self addChild: databaseDetails as: #details
]

{ #category : #accessing }
GtApLepiterDatabasePane >> initializeDatabaseDetails [
	databaseDetails := BrVerticalPane new matchParent
]

{ #category : #accessing }
GtApLepiterDatabasePane >> initializeDatabaseList [
	databaseList := BrColumnedList new hMatchParent vFitContent.

	databaseList column
		title: 'Name';
		width: 100;
		cellStencil: [ :each | BrLabel new aptitude: BrGlamorousLabelAptitude new ];
		dataBinder: [ :aLabel :eachItem | aLabel text: (eachItem at: 'name') ].


	databaseList column
		title: 'Description';
		matchParent;
		cellStencil: [ :each | BrLabel new aptitude: BrGlamorousLabelAptitude new ];
		dataBinder: [ :aLabel :eachItem | aLabel text: (eachItem at: 'description') ].

	databaseList column
		title: 'Location';
		width: 150;
		cellStencil: [ :each | BrLabel new aptitude: BrGlamorousLabelAptitude new ];
		dataBinder: [ :aLabel :eachItem | aLabel text: self server , '/' , (eachItem at: 'slug') ].

	databaseList addAptitude: BrColumnedListHeaderAptitude.

	databaseList addEventHandler: GtPhlowListToSelectHandler new.

	databaseList
		when: BrSelectionChanged
		do: [ :anEvent | 
			| selected |
			selected := databases at: anEvent indices first.
			self selectDatabase: selected ].

	databaseList
		rowStencil: (GtPhlowColumnedListItemElementWithContextMenuDecorator new
				stencilBuilder: (BrGlamorousColumnedListSelectableRowElementStencilBuilder new cellSpacing: 5))
]

{ #category : #accessing }
GtApLepiterDatabasePane >> postForPage: aPage [
	^ posts detect: [ :aPost | aPost page = aPage uid ] ifNone: [ nil ]
]

{ #category : #accessing }
GtApLepiterDatabasePane >> refreshDatabaseDetails [
	databaseDetails
		addChild: (BrLabel new
				aptitude: BrGlamorousLabelAptitude new bold;
				text: 'Pages';
				margin: (BlInsets top: 10 bottom: 5)).
	databaseDetails
		addChild: (BrSimpleList new beHorizontal hMatchParent vFitContent
				items: pages;
				itemStencil: [ GtApLepiterPageElement new
						server: server;
						token: token ];
				itemDataBinder: [ :anItemElement :anItem | 
					anItemElement
						page: anItem;
						post: (self postForPage: anItem);
						databaseId: (database at: 'ledatabase' at: 'uuid') ])
]

{ #category : #accessing }
GtApLepiterDatabasePane >> refreshDatabaseList [
	databases := STONJSON
			fromString: (ZnClient new beOneShot
					url: self server , '/api/databases';
					setBearerAuthentication: self token;
					get;
					response) entity string.

	databaseList items: databases
]

{ #category : #accessing }
GtApLepiterDatabasePane >> selectDatabase: aDb [
	database := aDb.
	pages := (ZnClient new beOneShot
			url: self server , '/api/pages?database=' , (aDb at: 'ledatabase' at: 'uuid');
			setBearerAuthentication: self token;
			get;
			response) entity string
			readStreamDo: [ :aStream | LeJsonV4 uniqueInstance deserialize: aStream ].
	posts := ((ZnClient new beOneShot
			url: self server , '/api/posts?database=' , (aDb at: 'slug');
			get;
			response) entity string
			readStreamDo: [ :aStream | LeJsonV4 uniqueInstance deserialize: aStream ])
			at: 'posts'.
			
	self refreshDatabaseDetails
]

{ #category : #accessing }
GtApLepiterDatabasePane >> server [
	^ server
]

{ #category : #accessing }
GtApLepiterDatabasePane >> server: anObject [
	server := anObject
]

{ #category : #accessing }
GtApLepiterDatabasePane >> token [
	^ token
]

{ #category : #accessing }
GtApLepiterDatabasePane >> token: anObject [
	token := anObject.
	self refreshDatabaseList
]
