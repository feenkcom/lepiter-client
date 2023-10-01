Class {
	#name : #LeClientCreateAttachment,
	#superclass : #LeClientCommand,
	#traits : 'TLeClientWithCommands',
	#classTraits : 'TLeClientWithCommands classTrait',
	#instVars : [
		'snippetAttachment',
		'serverDatabaseId'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #private }
LeClientCreateAttachment >> contentBlob [
	^ self command ifNotNil: [ :aCommand | aCommand blob ]
]

{ #category : #accessing }
LeClientCreateAttachment >> description [
	^ 'Publish attachment: ' , self snippetAttachment name
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
			ifNil: [ LeClientCannotExecute new ]
			ifNotNil: [ self context client
					endpoint: LeClientEndpoints apiCreateAttachment;
					authenticated;
					jsonObject: self jsonObject;
					post ].

	self addResponse: aResponse.
	^ aResponse
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
	| aCreateFile |
	self commands size > 1 ifTrue: [  "Commands were already created"^ self ].

	aCreateFile := LeClientCreateFile new
			context: context;
			snippetAttachment: snippetAttachment.

	self addCommand: aCreateFile.

	aCreateFile prepare
]

{ #category : #accessing }
LeClientCreateAttachment >> serverDatabaseId [
	<return: #String>
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientCreateAttachment >> serverDatabaseId: aString [
	serverDatabaseId := aString
]

{ #category : #accessing }
LeClientCreateAttachment >> snippetAttachment [
	^ snippetAttachment
]

{ #category : #accessing }
LeClientCreateAttachment >> snippetAttachment: anObject [
	snippetAttachment := anObject
]
