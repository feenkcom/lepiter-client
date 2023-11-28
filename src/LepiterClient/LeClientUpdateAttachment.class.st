Class {
	#name : #LeClientUpdateAttachment,
	#superclass : #LeClientApiCommand,
	#instVars : [
		'snippetAttachment',
		'serverDatabaseId',
		'createFile'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientUpdateAttachment class >> endPoint [
	^ LeClientEndpoints apiUpdateAttachment
]

{ #category : #accessing }
LeClientUpdateAttachment >> commands [
	^ LeClientUtility collectionWithoutNilItemFrom: createFile
]

{ #category : #private }
LeClientUpdateAttachment >> contentBlob [
	^ createFile ifNotNil: [ :aCommand | aCommand blob ]
]

{ #category : #accessing }
LeClientUpdateAttachment >> description [
	^ 'Update attachment: ' , self snippetAttachment name
]

{ #category : #accessing }
LeClientUpdateAttachment >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	self
		assert: [ snippetAttachment isNotNil ]
		description: [ 'Snippet attachment is not defined' ].

	self contentBlob ifNil: [ createFile execute ].

	aResponse := self contentBlob
			ifNil: [ LeClientCannotExecute new ]
			ifNotNil: [ self context zinc
					endpoint: LeClientEndpoints apiUpdateAttachment;
					authenticated;
					jsonObject: self jsonObject;
					addSubresponse: createFile lastResponse;
					post ].

	self addResponse: aResponse.
	^ aResponse
]

{ #category : #'gt - extensions' }
LeClientUpdateAttachment >> gtDetails [
	^ super gtDetails , {
		{ 'snippet attachment' . self snippetAttachment }.
		{ 'server database id' . self serverDatabaseId }.
		{ '1. create file'
			. createFile classAndDescription
			. createFile }
	}
]

{ #category : #private }
LeClientUpdateAttachment >> jsonObject [
	^ {'blob' -> self contentBlob.
		'fileName' -> snippetAttachment basename.
		'attachmentId' -> snippetAttachment uidString.
		'database' -> serverDatabaseId} asDictionary
]

{ #category : #'api - actions' }
LeClientUpdateAttachment >> prepare [
	self commands size > 1 ifTrue: [  "Commands were already created"^ self ].	
	
	"TODO: we want to call the createFile command only if the content is different"

	createFile := LeClientApiCreateFile new
			context: context;
			snippetAttachment: snippetAttachment.

	createFile prepare
]

{ #category : #accessing }
LeClientUpdateAttachment >> serverDatabaseId [
	<return: #String>
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientUpdateAttachment >> serverDatabaseId: aString [
	serverDatabaseId := aString
]

{ #category : #accessing }
LeClientUpdateAttachment >> snippetAttachment [
	<return: #LeSnippetAttachment>
	^ snippetAttachment
]

{ #category : #accessing }
LeClientUpdateAttachment >> snippetAttachment: anObject [
	snippetAttachment := anObject
]
