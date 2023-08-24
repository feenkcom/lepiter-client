Class {
	#name : #GtApLepiterAttachmentPoster,
	#superclass : #Object,
	#traits : 'TGtApLepiterWithClient',
	#classTraits : 'TGtApLepiterWithClient classTrait',
	#instVars : [
		'page',
		'serverDatabaseId',
		'serverFile',
		'snippetAttachments',
		'currentSnippetAttachment',
		'responses'
	],
	#category : #'LepiterClient-Publishing'
}

{ #category : #accessing }
GtApLepiterAttachmentPoster >> page [
	^ page
]

{ #category : #accessing }
GtApLepiterAttachmentPoster >> page: anObject [
	page := anObject
]

{ #category : #'api - publishing' }
GtApLepiterAttachmentPoster >> post [
	snippetAttachments := self page attachments all; get.
	
	snippetAttachments items do: [ :eachAttachment | 
		self postForAttachment: eachAttachment ].
		
	^ responses
]

{ #category : #'private - publishing' }
GtApLepiterAttachmentPoster >> postCreateAttachment [
	| aZnResponse anEntity anApResponse aClient |
	anEntity := ZnEntity
				json: (STONJSON toString: {
					'blob' -> serverFile blob.
					'fileName' -> currentSnippetAttachment name.
					'attachmentId' -> currentSnippetAttachment uidString.
					'database' -> self serverDatabaseId asString} asDictionary).
	
	aClient := ZnClient new beOneShot
		url: self server , '/api/createAttachment';
		entity: anEntity;
		setBearerAuthentication: self token.
	aZnResponse := aClient
		post;
		response.
		
	anApResponse := aZnResponse isSuccess
		ifTrue: [ GtApLepiterRequestSuccess new
			znClient: aClient ]
		ifFalse: [ GtApLepiterRequestFailure new
			znClient: aClient
			 ].
		
	responses add: anApResponse.
	
	^ anApResponse
]

{ #category : #'private - publishing' }
GtApLepiterAttachmentPoster >> postCreateFile [
	^ ZnClient new beOneShot
		url: self server , '/api/createFile';
		entity: (ZnEntity json: '{}');
		setBearerAuthentication: self token;
		post;
		response
]

{ #category : #'api - publishing' }
GtApLepiterAttachmentPoster >> postForAttachment: aSnippetAttachment [
	| aFileResponse anAttachmentResponse aJson |
	currentSnippetAttachment := aSnippetAttachment.
	
	aFileResponse := self postCreateFile.
	aFileResponse isSuccess ifFalse: [ ^ aFileResponse ].
	
	aJson := NeoJSONObject fromString: aFileResponse contents.
	serverFile := GtApLepiterServerFile new
		blob: (aJson at: #blob).
	
	anAttachmentResponse := self postCreateAttachment.
	
	^ anAttachmentResponse
]

{ #category : #accessing }
GtApLepiterAttachmentPoster >> serverDatabaseId [
	^ serverDatabaseId
]

{ #category : #accessing }
GtApLepiterAttachmentPoster >> serverDatabaseId: anObject [
	serverDatabaseId := anObject
]
