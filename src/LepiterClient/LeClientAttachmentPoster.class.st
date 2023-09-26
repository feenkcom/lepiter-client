Class {
	#name : #LeClientAttachmentPoster,
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

{ #category : #initialization }
LeClientAttachmentPoster >> initialize [
	super initialize.
	
	responses := OrderedCollection new.
]

{ #category : #accessing }
LeClientAttachmentPoster >> page [
	^ page
]

{ #category : #accessing }
LeClientAttachmentPoster >> page: anObject [
	page := anObject
]

{ #category : #'api - publishing' }
LeClientAttachmentPoster >> post [
	snippetAttachments := self page attachments all; get.
	
	snippetAttachments items do: [ :eachAttachment | 
		self postForAttachment: eachAttachment ].
		
	^ LeClientResponses new responses: responses
]

{ #category : #'private - publishing' }
LeClientAttachmentPoster >> postCreateAttachment [
	| aZnResponse anEntity anApResponse aZnClient |
	anEntity := ZnEntity
			json: (STONJSON
					toString: {'blob' -> serverFile blob.
							'fileName' -> currentSnippetAttachment basename.
							'attachmentId' -> currentSnippetAttachment uidString.
							'database' -> self serverDatabaseId asString} asDictionary).

	aZnClient := ZnClient new beOneShot
			url: self server , '/api/createAttachment';
			entity: anEntity;
			setBearerAuthentication: self token.
	aZnResponse := aZnClient
			post;
			response.

	anApResponse := LeClientRequestUtility responseForZnClient: aZnClient.

	responses add: anApResponse.

	^ anApResponse
]

{ #category : #'private - publishing' }
LeClientAttachmentPoster >> postCreateFile [
	| aZnResponse anApResponse aClient |
	self flag: 'use stream instead of bytes:'.

	aClient := ZnClient new beOneShot
		url: self server , '/api/createFile';
		entity: (ZnEntity bytes: currentSnippetAttachment contents);
		setBearerAuthentication: self token.
		
	aZnResponse := aClient
		post;
		response.
		
	anApResponse := aZnResponse isSuccess
			ifTrue: [ LeClientRequestSuccess new znClient: aClient ]
			ifFalse: [ LeClientRequestFailure new znClient: aClient ].

	responses add: anApResponse.
	
	^ anApResponse
]

{ #category : #'api - publishing' }
LeClientAttachmentPoster >> postForAttachment: aSnippetAttachment [
	| aFileResponse anAttachmentResponse aJson |
	currentSnippetAttachment := aSnippetAttachment.
	
	aFileResponse := self postCreateFile.
	aFileResponse isSuccess ifFalse: [ ^ aFileResponse ].
	
	aJson := NeoJSONObject fromString: aFileResponse contents.
	serverFile := LeClientFile new
		blob: (aJson at: #blob).
	
	anAttachmentResponse := self postCreateAttachment.
	
	^ anAttachmentResponse
]

{ #category : #accessing }
LeClientAttachmentPoster >> serverDatabaseId [
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientAttachmentPoster >> serverDatabaseId: anObject [
	serverDatabaseId := anObject
]
