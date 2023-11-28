Class {
	#name : #LeClientAttachmentPublisher,
	#superclass : #LeClientCompositeCommand,
	#traits : 'TLeClientWithCommands',
	#classTraits : 'TLeClientWithCommands classTrait',
	#instVars : [
		'page',
		'serverDatabaseId',
		'snippetAttachments'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientAttachmentPublisher >> description [
	^ 'Publish {1} {2}'
		format: {self commands size.
				'attachment' asPluralBasedOn: self commands size}
]

{ #category : #'api - actions' }
LeClientAttachmentPublisher >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	self
		ifSuccess: [ :aPreviousResponse | ^ aPreviousResponse ]
		ifFailure: [  "repeat" ]
		ifNone: [  "execute" ].

	self commands do: #execute.
	aResponse := LeClientMultiResponse fromCommand: self.
	self addResponse: aResponse.
	^ aResponse
]

{ #category : #'gt - extensions' }
LeClientAttachmentPublisher >> gtDetails [
	^ super gtDetails , {
		{ 'page' . self page }.
		{ 'server database id' . self serverDatabaseId }.
		{ 'snippet attachments' . snippetAttachments size. snippetAttachments }.
		{ 'n. create or update attachments' . self commands size . self commands }
	}
]

{ #category : #private }
LeClientAttachmentPublisher >> onServerDatabaseIdChange [
	self commands
		do: [ :aCommand | 
			aCommand check serverDatabaseId: serverDatabaseId.
			aCommand onSuccess serverDatabaseId: serverDatabaseId.
			aCommand onNotFound serverDatabaseId: serverDatabaseId ]
]

{ #category : #accessing }
LeClientAttachmentPublisher >> page [
	<return: #LePage>
	^ page
]

{ #category : #accessing }
LeClientAttachmentPublisher >> page: aPage [
	page := aPage
]

{ #category : #'api - actions' }
LeClientAttachmentPublisher >> prepare [
	self page ifNil: [  "Command is not ready for initialization"^ self ].

	snippetAttachments := self page attachments
			all;
			get.
	snippetAttachments
		do: [ :eachAttachment | self prepareForAttachment: eachAttachment ].

	self commands do: #prepare.
	
	self commands ifEmpty: [ self addResponse: LeClientReadyResponse new ]
]

{ #category : #private }
LeClientAttachmentPublisher >> prepareForAttachment: aSnippetAttachment [
	| aCommand |
	aCommand := LeClientCondition new
			description: 'Create or update attachment: ' , aSnippetAttachment name;
			context: context;
			check: (LeClientCheckAttachmentExist new
					context: context;
					snippetAttachment: aSnippetAttachment;
					serverDatabaseId: serverDatabaseId);
			onSuccess: (LeClientUpdateAttachment new
					context: context;
					snippetAttachment: aSnippetAttachment;
					serverDatabaseId: serverDatabaseId);
			onNotFound: (LeClientCreateAttachment new
					context: context;
					snippetAttachment: aSnippetAttachment;
					serverDatabaseId: serverDatabaseId).

	self addCommand: aCommand
]

{ #category : #accessing }
LeClientAttachmentPublisher >> serverDatabaseId [
	<return: #String>
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientAttachmentPublisher >> serverDatabaseId: anObject [
	serverDatabaseId := anObject.
	self onServerDatabaseIdChange
]
