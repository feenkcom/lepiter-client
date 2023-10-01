Class {
	#name : #LeClientCheckPage,
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
LeClientCheckPage >> description [
	^ 'Check page exists: ' , self page title asString
]

{ #category : #'api - actions' }
LeClientCheckPage >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	self
		ifSuccessDo: [ ^ self ]
		ifFailureDo: [  "execute again" ]
		ifNone: [  "execute" ].

	aResponse := self getPage.
	aResponse isSuccess
		ifFalse: [ self commands do: #execute.
			aResponse := LeClientCommandsResponse fromCommand: self.
			self addResponse: aResponse ].
	^ aResponse
]

{ #category : #'api - actions' }
LeClientCheckPage >> getPage [
	| aResponse |
	aResponse := self context client
			endpoint: LeClientEndpoints apiPage;
			authenticated;
			queryAt: #page put: page uidString;
			queryAt: #database put: serverDatabaseId;
			get.
	self addResponse: aResponse.
	^ aResponse
]

{ #category : #accessing }
LeClientCheckPage >> page [
	<return: #LePage>
	^ page
]

{ #category : #accessing }
LeClientCheckPage >> page: aPage [
	page := aPage
]

{ #category : #'api - actions' }
LeClientCheckPage >> prepare [
	self page ifNil: [  "Command is not ready for initialization"^ self ].

	self preparePage.
	self commands do: #prepare
]

{ #category : #private }
LeClientCheckPage >> prepareAttachments [
	| anAttachmentPublisher |
	anAttachmentPublisher := LeClientAttachmentPublisher new
			context: context;
			page: page;
			serverDatabaseId: serverDatabaseId.

	self addCommand: anAttachmentPublisher
]

{ #category : #'api - actions' }
LeClientCheckPage >> preparePage [
	| aPagePublisher |
	aPagePublisher := LeClientPagePublisher new
		context: context;
		page: page;
		serverDatabaseId: serverDatabaseId.
		
	self addCommand: aPagePublisher
]

{ #category : #accessing }
LeClientCheckPage >> serverDatabaseId [
	<return: #String>
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientCheckPage >> serverDatabaseId: aString [
	serverDatabaseId := aString
]
