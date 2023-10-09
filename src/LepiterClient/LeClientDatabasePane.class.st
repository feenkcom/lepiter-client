Class {
	#name : #LeClientDatabasePane,
	#superclass : #BrVerticalPane,
	#instVars : [
		'client',
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
LeClientDatabasePane >> client [
	^ client
]

{ #category : #accessing }
LeClientDatabasePane >> client: anObject [
	client := anObject.
	self refreshDatabaseList
]

{ #category : #accessing }
LeClientDatabasePane >> initialize [
	super initialize.
	
	self initializeDatabaseList.
	self initializeDatabaseDetails.
	
	self addChild: databaseList as: #databases.
	self addChild: databaseDetails as: #details
]

{ #category : #accessing }
LeClientDatabasePane >> initializeDatabaseDetails [
	databaseDetails := BrVerticalPane new matchParent
]

{ #category : #accessing }
LeClientDatabasePane >> initializeDatabaseList [
	databaseList := BrColumnedList new hMatchParent vFitContent.

	databaseList column
		title: 'Name';
		width: 100;
		cellStencil: [ :each | BrLabel new aptitude: BrGlamorousLabelAptitude new ];
		dataBinder: [ :aLabel :eachItem | aLabel text: eachItem name ].


	databaseList column
		title: 'Description';
		matchParent;
		cellStencil: [ :each | BrLabel new aptitude: BrGlamorousLabelAptitude new ];
		dataBinder: [ :aLabel :eachItem | aLabel text: eachItem description ].

	databaseList column
		title: 'Location';
		width: 150;
		cellStencil: [ :each | BrLabel new aptitude: BrGlamorousLabelAptitude new ];
		dataBinder: [ :aLabel :eachItem | aLabel text: '/' , eachItem slug ].

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
LeClientDatabasePane >> postForPage: aPage [
	^ posts detect: [ :aPost | aPost page = aPage uid ] ifNone: [ nil ]
]

{ #category : #accessing }
LeClientDatabasePane >> refreshDatabaseDetails [
	databaseDetails
		addChild: (BrLabel new
				aptitude: BrGlamorousLabelAptitude new bold;
				text: 'Pages';
				margin: (BlInsets top: 10 bottom: 5)).
	databaseDetails
		addChild: (BrSimpleList new beHorizontal hMatchParent vFitContent
				items: pages;
				itemStencil: [ LeClientPageElement new
						server: server;
						token: token ];
				itemDataBinder: [ :anItemElement :anItem | 
					anItemElement
						page: anItem;
						post: (self postForPage: anItem);
						databaseId: (database at: 'ledatabase' at: 'uuid') ])
]

{ #category : #accessing }
LeClientDatabasePane >> refreshDatabaseList [
	databases := self client databases.

	databaseList items: databases
]

{ #category : #accessing }
LeClientDatabasePane >> selectDatabase: aDb [
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
