Class {
	#name : #LePagePublishClient,
	#superclass : #Object,
	#instVars : [
		'loginPane',
		'databasePane',
		'client',
		'page',
		'post',
		'server',
		'allResults'
	],
	#category : #'LepiterClient-UI'
}

{ #category : #private }
LePagePublishClient >> addResult: aResult [
	allResults add: aResult
]

{ #category : #accessing }
LePagePublishClient >> client [
	^ client
]

{ #category : #accessing }
LePagePublishClient >> client: aClient [
	client := aClient.
	self server: aClient server.
	self tryToResolvePage
]

{ #category : #accessing }
LePagePublishClient >> gtCommandsFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Results';
		priority: 80;
		items: [ allResults ifNil: [ #() ] ];
		children: #commands;
		expandAll;
		column: 'Description' text: #description;
		column: 'Response'
			text: [ :aCommand | aCommand lastResponse ifNotNil: #label ]
			width: 120;
		contextItemLabel: 'Inspect response'
			action: [ :anElement :aTreeNode | anElement phlow spawnObject: aTreeNode value lastResponse ];
		actionUpdateButton
]

{ #category : #accessing }
LePagePublishClient >> gtLoginFor: aView [
	<gtView>
	self client ifNotNil: [ ^ aView empty ].

	^ aView explicit
		title: 'Login';
		priority: 1;
		stencil: [ | login |
			login := LeClientLoginPane new onLogin: [ :aClient | self client: aClient ].
			self server ifNotNil: [ login server: self server ].
			login ]
]

{ #category : #accessing }
LePagePublishClient >> gtPostFor: aView [
	<gtView>
	self post ifNil: [ ^ aView empty ].


	^ aView forward
		title: 'Post';
		priority: 2;
		object: self post;
		view: #gtViewCardFor:
]

{ #category : #accessing }
LePagePublishClient >> gtPublishFor: aView [
	<gtView>
	^ aView forward
		title: 'Publish';
		priority: 2;
		object: [ LeClientPublishPageForm new
				client: self client;
				page: self page;
				onCommandCreation: [ :aCommand | self addResult: aCommand ];
				onPublish: [ :aResult | self resolvePage ] ];
		view: #gtMagritteFor:
]

{ #category : #accessing }
LePagePublishClient >> initialize [
	super initialize.
	allResults := OrderedCollection new
]

{ #category : #accessing }
LePagePublishClient >> page [
	^ page
]

{ #category : #accessing }
LePagePublishClient >> page: anObject [
	page := anObject.
	self tryToResolvePage
]

{ #category : #accessing }
LePagePublishClient >> post [
	^ post
]

{ #category : #accessing }
LePagePublishClient >> post: anObject [
	post := anObject
]

{ #category : #accessing }
LePagePublishClient >> resolvePage [
	| aResponse |
	aResponse := self client findPostByPage: self page.

	self addResult: aResponse.

	aResponse isSuccess
		ifTrue: [ self post: (aResponse model client: self client) ]
]

{ #category : #accessing }
LePagePublishClient >> server [
	^ server
]

{ #category : #accessing }
LePagePublishClient >> server: anObject [
	server := anObject
]

{ #category : #accessing }
LePagePublishClient >> tryToResolvePage [
	(self page isNotNil and: [ self client isNotNil and: [ self post isNil ] ])
		ifTrue: [ self resolvePage ]
]
