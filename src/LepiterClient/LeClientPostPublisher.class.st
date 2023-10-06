Class {
	#name : #LeClientPostPublisher,
	#superclass : #LeClientCommand,
	#traits : 'TLeClientWithCommands',
	#classTraits : 'TLeClientWithCommands classTrait',
	#instVars : [
		'page',
		'serverDatabaseId'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientPostPublisher >> description [
	^ 'Publish post: ' , self page title
]

{ #category : #accessing }
LeClientPostPublisher >> page [
	<return: #LePage>
	^ page
]

{ #category : #accessing }
LeClientPostPublisher >> page: aPage [
	page := aPage
]

{ #category : #'api - actions' }
LeClientPostPublisher >> prepare [
	self page ifNil: [  "Command is not ready for initialization"^ self ].

	self preparePage.
	self commands do: #prepare
]

{ #category : #'api - actions' }
LeClientPostPublisher >> preparePage [
	| aPagePublisher |
	aPagePublisher := LeClientPagePublisher new
		context: context;
		page: page;
		serverDatabaseId: serverDatabaseId.
		
	self addCommand: aPagePublisher
]

{ #category : #accessing }
LeClientPostPublisher >> serverDatabaseId [
	<return: #String>
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientPostPublisher >> serverDatabaseId: aString [
	serverDatabaseId := aString
]
