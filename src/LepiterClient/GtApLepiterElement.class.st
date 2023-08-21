Class {
	#name : #GtApLepiterElement,
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
GtApLepiterElement >> initialize [
	super initialize.
	
	self matchParent.
	
	self initializeLoginPane.
	
	self initializeDatabasePane.
	
	self addChild: loginPane as: #'login-pane'.
	self addChild: databasePane as: #'database-pane'
]

{ #category : #accessing }
GtApLepiterElement >> initializeDatabasePane [
	databasePane := GtApLepiterDatabasePane new matchParent
			visibility: BlVisibility gone
]

{ #category : #accessing }
GtApLepiterElement >> initializeLoginPane [
	loginPane := (GtApLepiterLoginPane new
			onLogin: [ :aPair | 
				self server: aPair key.
				self setToken: aPair value ]) asElement matchParent
]

{ #category : #accessing }
GtApLepiterElement >> server [
	^ server
]

{ #category : #accessing }
GtApLepiterElement >> server: anObject [
	server := anObject.
	databasePane server: anObject
]

{ #category : #accessing }
GtApLepiterElement >> setToken: aToken [
	self token: aToken.
	loginPane
		visibility: (aToken ifNil: [ BlVisibility visible ] ifNotNil: [ BlVisibility gone ]).
	databasePane
		visibility: (aToken ifNil: [ BlVisibility gone ] ifNotNil: [ BlVisibility visible ]).
	databasePane token: aToken
]

{ #category : #accessing }
GtApLepiterElement >> token [
	^ token
]

{ #category : #accessing }
GtApLepiterElement >> token: anObject [
	token := anObject
]
