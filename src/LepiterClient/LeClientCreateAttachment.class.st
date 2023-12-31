Class {
	#name : #LeClientCreateAttachment,
	#superclass : #LeClientApiCommand,
	#instVars : [
		'snippetAttachment',
		'createFile',
		'serverDatabaseId'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientCreateAttachment class >> endPoint [
	^ LeClientEndpoints apiCreateAttachment
]

{ #category : #accessing }
LeClientCreateAttachment >> commands [
	^ LeClientUtility collectionWithoutNilItemFrom: createFile
]

{ #category : #private }
LeClientCreateAttachment >> contentBlob [
	^ createFile ifNotNil: [ :aCommand | aCommand blob ]
]

{ #category : #accessing }
LeClientCreateAttachment >> description [
	^ 'Create attachment: ' , self snippetAttachment name
]

{ #category : #accessing }
LeClientCreateAttachment >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	self
		assert: [ snippetAttachment isNotNil ]
		description: [ 'Snippet attachment is not defined' ].

	self contentBlob ifNil: [ self commands do: #execute ].

	aResponse := self contentBlob
			ifNil: [ LeClientCannotExecute new subresponse: createFile lastResponse ]
			ifNotNil: [ self context zinc
					endpoint: LeClientEndpoints apiCreateAttachment;
					authenticated;
					jsonObject: self jsonObject;
					addSubresponse: createFile lastResponse;
					post ].

	self addResponse: aResponse.
	^ aResponse
]

{ #category : #'gt - extensions' }
LeClientCreateAttachment >> gtDetails [
	^ super gtDetails , {
		{ 'snippet attachment' . self snippetAttachment }.
		{ 'server database id' . self serverDatabaseId }.
		{ '1. create file'
			. createFile classAndDescription
			. createFile }
	}
]

{ #category : #private }
LeClientCreateAttachment >> jsonObject [
	^ {'blob' -> self contentBlob.
		'fileName' -> snippetAttachment basename.
		'attachmentId' -> snippetAttachment uidString.
		'database' -> serverDatabaseId} asDictionary
]

{ #category : #'api - actions' }
LeClientCreateAttachment >> prepare [
	createFile ifNotNil: [ ^ self ].

	createFile := LeClientApiCreateFile new
			context: context;
			snippetAttachment: snippetAttachment.

	createFile prepare
]

{ #category : #accessing }
LeClientCreateAttachment >> serverDatabaseId [
	<return: #String>
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientCreateAttachment >> serverDatabaseId: aString [
	serverDatabaseId := aString.
]

{ #category : #accessing }
LeClientCreateAttachment >> snippetAttachment [
	<return: #LeSnippetAttachment>
	^ snippetAttachment
]

{ #category : #accessing }
LeClientCreateAttachment >> snippetAttachment: anObject [
	snippetAttachment := anObject
]
