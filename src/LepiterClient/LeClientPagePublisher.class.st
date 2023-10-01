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
LeClientPagePublisher >> description [
	^ 'Publish page: ' , self page title asString
]

{ #category : #'api - actions' }
LeClientPagePublisher >> execute [
	| aResponse |
	self commands do: #execute.

	self
		ifSuccessDo: [ ^ self ]
		ifFailureDo: [  "execute again" ]
		ifNone: [  "execute" ].

	aResponse := self context client
			endpoint: LeClientEndpoints apiCreatePage;
			lepiterObject: self lepiterObject;
			authenticated;
			onSuccessLepiterModel;
			post.
	self addResponse: aResponse
]

{ #category : #private }
LeClientPagePublisher >> lepiterObject [
	^ {'page' -> self page.
		'database' -> self serverDatabaseId asString} asDictionary
]

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