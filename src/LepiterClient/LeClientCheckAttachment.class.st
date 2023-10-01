Class {
	#name : #LeClientCheckAttachment,
	#superclass : #LeClientCommand,
	#traits : 'TLeClientWithCommands',
	#classTraits : 'TLeClientWithCommands classTrait',
	#instVars : [
		'snippetAttachment',
		'serverDatabaseId'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientCheckAttachment >> description [
	^ 'Check attachment exists: ' , self snippetAttachment name
]

{ #category : #'api - actions' }
LeClientCheckAttachment >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	self
		assert: [ snippetAttachment isNotNil ]
		description: [ 'Snippet attachment is not defined' ].

	self
		ifSuccessDo: [ ^ self ]
		ifFailureDo: [  "execute again" ]
		ifNone: [  "execute again" ].

	aResponse := self context client
			endpoint: LeClientEndpoints apiAttachment;
			authenticated;
			entity: (ZnEntity bytes: snippetAttachment contents);
			queryAt: #attachmentId put: snippetAttachment uidString;
			queryAt: #database put: serverDatabaseId;
			post.
	self addResponse: aResponse.

	aResponse isSuccess
		ifFalse: [ self commands do: #execute.
			aResponse := LeClientCommandsResponse fromCommand: self.
			self addResponse: aResponse ].

	^ aResponse
]

{ #category : #'api - actions' }
LeClientCheckAttachment >> prepare [
	| aCreateAttachment |
	self commands size > 1 ifTrue: [  "Commands were already created"^ self ].

	aCreateAttachment := LeClientCreateAttachment new
			context: context;
			snippetAttachment: snippetAttachment.

	self addCommand: aCreateAttachment.

	aCreateAttachment prepare
]

{ #category : #accessing }
LeClientCheckAttachment >> serverDatabaseId [
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientCheckAttachment >> serverDatabaseId: anObject [
	serverDatabaseId := anObject
]

{ #category : #accessing }
LeClientCheckAttachment >> snippetAttachment [
	^ snippetAttachment
]

{ #category : #accessing }
LeClientCheckAttachment >> snippetAttachment: anObject [
	snippetAttachment := anObject
]
