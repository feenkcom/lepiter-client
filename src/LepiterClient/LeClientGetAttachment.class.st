Class {
	#name : #LeClientGetAttachment,
	#superclass : #LeClientCommand,
	#instVars : [
		'snippetAttachment',
		'serverDatabaseId'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientGetAttachment >> attachmentHash [
	<return: #ByteArray or: nil>
	^ self lastResponse
		ifExist: [ :aResponse | aResponse model at: #hash ifAbsent: [ nil ] ]
		ifMissing: [ nil ]
		ifFailure: [ nil ]
		ifNone: [ nil ]
]

{ #category : #accessing }
LeClientGetAttachment >> attachmentSize [
	<return: #Integer or: nil>
	^ self lastResponse
		ifExist: [ :aResponse | aResponse model at: #size ifAbsent: [ nil ] ]
		ifMissing: [ nil ]
		ifFailure: [ nil ]
		ifNone: [ nil ]
]

{ #category : #accessing }
LeClientGetAttachment >> description [
	^ 'Check attachment exists: ' , self snippetAttachment name
]

{ #category : #'api - actions' }
LeClientGetAttachment >> execute [
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
LeClientGetAttachment >> prepare [
	"nothing to do"

	
]

{ #category : #accessing }
LeClientGetAttachment >> serverDatabaseId [
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientGetAttachment >> serverDatabaseId: anObject [
	serverDatabaseId := anObject
]

{ #category : #accessing }
LeClientGetAttachment >> snippetAttachment [
	^ snippetAttachment
]

{ #category : #accessing }
LeClientGetAttachment >> snippetAttachment: anObject [
	snippetAttachment := anObject
]
