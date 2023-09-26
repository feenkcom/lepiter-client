Class {
	#name : #LeClientElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'server',
		'token',
		'loginPane',
		'databasePane'
	],
	#category : #'LepiterClient-UI'
}

{ #category : #accessing }
LeClientElement >> initialize [
	super initialize.
	
	self matchParent.
	
	self initializeLoginPane.
	
	self initializeDatabasePane.
	
	self addChild: loginPane as: #'login-pane'.
	self addChild: databasePane as: #'database-pane'
]

{ #category : #accessing }
LeClientElement >> initializeDatabasePane [
	databasePane := LeClientDatabasePane new matchParent
			visibility: BlVisibility gone
]

{ #category : #accessing }
LeClientElement >> initializeLoginPane [
	loginPane := (LeClientLoginPane new
			onLogin: [ :aPair | 
				self server: aPair key.
				self setToken: aPair value ]) asElement matchParent
]

{ #category : #accessing }
LeClientElement >> server [
	^ server
]

{ #category : #accessing }
LeClientElement >> server: anObject [
	server := anObject.
	databasePane server: anObject
]

{ #category : #accessing }
LeClientElement >> setToken: aToken [
	self token: aToken.
	loginPane
		visibility: (aToken ifNil: [ BlVisibility visible ] ifNotNil: [ BlVisibility gone ]).
	databasePane
		visibility: (aToken ifNil: [ BlVisibility gone ] ifNotNil: [ BlVisibility visible ]).
	databasePane token: aToken
]

{ #category : #accessing }
LeClientElement >> token [
	^ token
]

{ #category : #accessing }
LeClientElement >> token: anObject [
	token := anObject
]
