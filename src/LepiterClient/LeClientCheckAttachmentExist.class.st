Class {
	#name : #LeClientCheckAttachmentExist,
	#superclass : #LeClientCommand,
	#instVars : [
		'snippetAttachment',
		'serverDatabaseId',
		'getAttachment'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientCheckAttachmentExist >> attachmentHash [
	<return: #ByteArray or: nil>
	^ self lastResponse
		ifExist: [ :aResponse | aResponse model at: #hash ifAbsent: [ nil ] ]
		ifMissing: [ nil ]
		ifFailure: [ nil ]
		ifNone: [ nil ]
]

{ #category : #accessing }
LeClientCheckAttachmentExist >> attachmentSize [
	<return: #Integer or: nil>
	^ self lastResponse
		ifExist: [ :aResponse | aResponse model at: #size ifAbsent: [ nil ] ]
		ifMissing: [ nil ]
		ifFailure: [ nil ]
		ifNone: [ nil ]
]

{ #category : #accessing }
LeClientCheckAttachmentExist >> description [
	^ 'Check attachment exists: ' , self snippetAttachment name
]

{ #category : #'api - actions' }
LeClientCheckAttachmentExist >> execute [
	<return: #TLeClientResponse>
	| aGetResponse aResponse |
	self
		assert: [ snippetAttachment isNotNil ]
		description: [ 'Snippet attachment is not defined' ].

	aGetResponse := getAttachment execute.
	aResponse := LeClientModelExistResponse new subresponse: aGetResponse.
	self addResponse: aResponse.

	^ aResponse
]

{ #category : #private }
LeClientCheckAttachmentExist >> onServerDatabaseIdChange [
	getAttachment
		ifNotNil: [ :aCommand | aCommand serverDatabaseId: serverDatabaseId ]
]

{ #category : #'api - actions' }
LeClientCheckAttachmentExist >> prepare [
	getAttachment ifNotNil: [ ^ self ].
	getAttachment := LeClientApiAttachment new
			context: context;
			snippetAttachment: snippetAttachment;
			serverDatabaseId: serverDatabaseId
]

{ #category : #accessing }
LeClientCheckAttachmentExist >> serverDatabaseId [
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientCheckAttachmentExist >> serverDatabaseId: anObject [
	serverDatabaseId := anObject.
	self onServerDatabaseIdChange
]

{ #category : #accessing }
LeClientCheckAttachmentExist >> snippetAttachment [
	<return: #LeSnippetAttachment>
	^ snippetAttachment
]

{ #category : #accessing }
LeClientCheckAttachmentExist >> snippetAttachment: anObject [
	snippetAttachment := anObject
]
