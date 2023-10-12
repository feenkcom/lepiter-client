Class {
	#name : #LeClientApiAttachment,
	#superclass : #LeClientCommand,
	#instVars : [
		'snippetAttachment',
		'serverDatabaseId'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientApiAttachment >> attachmentHash [
	<return: #ByteArray or: nil>
	^ self lastResponse
		ifExist: [ :aResponse | aResponse model at: #hash ifAbsent: [ nil ] ]
		ifMissing: [ nil ]
		ifFailure: [ nil ]
		ifNone: [ nil ]
]

{ #category : #accessing }
LeClientApiAttachment >> attachmentSize [
	<return: #Integer or: nil>
	^ self lastResponse
		ifExist: [ :aResponse | aResponse model at: #size ifAbsent: [ nil ] ]
		ifMissing: [ nil ]
		ifFailure: [ nil ]
		ifNone: [ nil ]
]

{ #category : #accessing }
LeClientApiAttachment >> description [
	^ 'Check attachment exists: ' , self snippetAttachment name
]

{ #category : #'api - actions' }
LeClientApiAttachment >> execute [
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
	self addResponse: aResponse.
	^ aResponse
]

{ #category : #'api - actions' }
LeClientApiAttachment >> prepare [
	"nothing to do"

	
]

{ #category : #accessing }
LeClientApiAttachment >> serverDatabaseId [
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientApiAttachment >> serverDatabaseId: anObject [
	serverDatabaseId := anObject
]

{ #category : #accessing }
LeClientApiAttachment >> snippetAttachment [
	<return: #LeSnippetAttachment>
	^ snippetAttachment
]

{ #category : #accessing }
LeClientApiAttachment >> snippetAttachment: anObject [
	snippetAttachment := anObject
]
