Class {
	#name : #LePagePublishClient,
	#superclass : #Object,
	#instVars : [
		'loginPane',
		'databasePane',
		'client',
		'page',
		'post',
		'server'
	],
	#category : #'LepiterClient-UI'
}

{ #category : #accessing }
LePagePublishClient >> client [
	^ client
]

{ #category : #accessing }
LePagePublishClient >> client: aClient [
	client := aClient.
	self server: aClient server
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
	self client ifNil: [ ^ aView empty ].
	(self client findPostByPage: self page) isSuccess ifTrue: [ ^ aView empty ].

	^ aView forward
		title: 'Publish';
		priority: 2;
		object: [ LeClientPublishPageForm new
				client: self client;
				page: self page;
				onPublish: [ :aPost | 
					| serverPostResponse |
					serverPostResponse := self client findPostByPage: self page.

					serverPostResponse isSuccess
						ifTrue: [ self post: (serverPostResponse model client: self client) ] ] ];
		view: #gtMagritteFor:
]

{ #category : #accessing }
LePagePublishClient >> initialize [
	super initialize
]

{ #category : #accessing }
LePagePublishClient >> page [
	^ page
]

{ #category : #accessing }
LePagePublishClient >> page: anObject [
	page := anObject
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
LePagePublishClient >> server [
	^ server
]

{ #category : #accessing }
LePagePublishClient >> server: anObject [
	server := anObject
]
