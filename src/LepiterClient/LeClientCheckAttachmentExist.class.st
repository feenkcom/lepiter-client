Class {
	#name : #LeClientCheckAttachmentExist,
	#superclass : #LeClientCommand,
	#instVars : [
		'snippetAttachment',
		'serverDatabaseId'
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
	| aResponse |
	self
		assert: [ snippetAttachment isNotNil ]
		description: [ 'Snippet attachment is not defined' ].

	aResponse := self context client
			endpoint: LeClientEndpoints apiAttachment;
			authenticated;
			entity: (ZnEntity bytes: snippetAttachment contents);
			queryAt: #attachmentId put: snippetAttachment uidString;
			queryAt: #database put: serverDatabaseId;
			onSuccessLepiterModel;
			get.
	aResponse := LeClientModelExistResponse new subresponse: aResponse.
	self addResponse: aResponse.

	^ aResponse
]

{ #category : #'api - actions' }
LeClientCheckAttachmentExist >> prepare [
	"nothing to do"

	
]

{ #category : #accessing }
LeClientCheckAttachmentExist >> serverDatabaseId [
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientCheckAttachmentExist >> serverDatabaseId: anObject [
	serverDatabaseId := anObject
]

{ #category : #accessing }
LeClientCheckAttachmentExist >> snippetAttachment [
	^ snippetAttachment
]

{ #category : #accessing }
LeClientCheckAttachmentExist >> snippetAttachment: anObject [
	snippetAttachment := anObject
]
