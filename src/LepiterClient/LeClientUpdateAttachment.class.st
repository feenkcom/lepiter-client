Class {
	#name : #LeClientUpdateAttachment,
	#superclass : #LeClientCommand,
	#instVars : [
		'snippetAttachment',
		'serverDatabaseId',
		'createFile'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientUpdateAttachment >> commands [
	^ LeClientCommandUtility collectionForCommand: createFile
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
			ifNotNil: [ self context client
					endpoint: LeClientEndpoints apiUpdateAttachment;
					authenticated;
					jsonObject: self jsonObject;
					addSubresponse: createFile lastResponse;
					post ].

	self addResponse: aResponse.
	^ aResponse
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

	createFile := LeClientCreateFile new
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
	^ snippetAttachment
]

{ #category : #accessing }
LeClientUpdateAttachment >> snippetAttachment: anObject [
	snippetAttachment := anObject
]
