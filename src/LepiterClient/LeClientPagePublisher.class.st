Class {
	#name : #LeClientPagePublisher,
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
LeClientPagePublisher >> page [
	<return: #LePage>
	^ page
]

{ #category : #accessing }
LeClientPagePublisher >> page: aPage [
	page := aPage
]

{ #category : #'api - actions' }
LeClientPagePublisher >> prepare [
	self page ifNil: [  "Command is not ready for initialization"^ self ].

	self prepareAttachments.
	self commands do: #prepare
]

{ #category : #private }
LeClientPagePublisher >> prepareAttachments [
	| anAttachmentPublisher |
	anAttachmentPublisher := LeClientAttachmentPublisher new
			context: context;
			page: page;
			serverDatabaseId: serverDatabaseId.

	self addCommand: anAttachmentPublisher
]

{ #category : #accessing }
LeClientPagePublisher >> serverDatabaseId [
	<return: #String>
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientPagePublisher >> serverDatabaseId: aString [
	serverDatabaseId := aString
]
