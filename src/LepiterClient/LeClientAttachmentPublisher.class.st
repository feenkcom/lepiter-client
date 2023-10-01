Class {
	#name : #LeClientAttachmentPublisher,
	#superclass : #LeClientCommand,
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
	| aResponse |
	self commands do: #execute.
	aResponse := LeClientCommandsResponse fromCommand: self.
	self addResponse: aResponse
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

	self commands do: #prepare
]

{ #category : #'private - actions' }
LeClientAttachmentPublisher >> prepareForAttachment: aSnippetAttachment [
	| aCommand |
	aCommand := LeClientCheckAttachment new
			context: context;
			serverDatabaseId: serverDatabaseId;
			snippetAttachment: aSnippetAttachment.
			
	self addCommand: aCommand
]

{ #category : #accessing }
LeClientAttachmentPublisher >> serverDatabaseId [
	<return: #String>
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientAttachmentPublisher >> serverDatabaseId: anObject [
	serverDatabaseId := anObject
]
