Class {
	#name : #LeClientPagePublisher,
	#superclass : #LeClientCommand,
	#instVars : [
		'page',
		'serverDatabaseId',
		'attachmentPublisher',
		'createOrUpdatePage'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientPagePublisher >> commands [
	^ LeClientUtility collectionWithoutNilItemsFrom: {attachmentPublisher. createOrUpdatePage}
]

{ #category : #accessing }
LeClientPagePublisher >> description [
	^ 'Publish page: ' , self page title asString
]

{ #category : #'api - actions' }
LeClientPagePublisher >> execute [
	<return: #TLeClientResponse>
	| aResponse anAttachmentResponse aPageResponse |
	self
		ifSuccess: [ ^ self lastResponse ]
		ifFailure: [  "execute again" ]
		ifNone: [  "execute" ].

	anAttachmentResponse := attachmentPublisher execute.
	anAttachmentResponse
		ifSuccess: [ aPageResponse := createOrUpdatePage execute ]
		ifFailure: [ aPageResponse := LeClientNoResponse new ]
		ifNone: [ aPageResponse := LeClientNoResponse new ].
	aResponse := LeClientMultiResponse new 
		subresponses: {anAttachmentResponse. aPageResponse}.
	self addResponse: aResponse.
	^ aResponse
]

{ #category : #private }
LeClientPagePublisher >> lepiterObject [
	^ {'page' -> self page.
		'database' -> self serverDatabaseId asString} asDictionary
]

{ #category : #accessing }
LeClientPagePublisher >> page [
	<return: #LePage>
	^ page
]

{ #category : #accessing }
LeClientPagePublisher >> page: aPage [
	page := aPage
]

{ #category : #'api - actions' }
LeClientPagePublisher >> prepare [
	self page ifNil: [  "Command is not ready for initialization"^ self ].

	self prepareAttachments.
	self prepareCreateOrUpdatePage.
]

{ #category : #private }
LeClientPagePublisher >> prepareAttachments [
	attachmentPublisher := LeClientAttachmentPublisher new
			context: context;
			page: page;
			serverDatabaseId: serverDatabaseId.
	attachmentPublisher prepare
]

{ #category : #private }
LeClientPagePublisher >> prepareCreateOrUpdatePage [
	createOrUpdatePage := LeClientCondition new
			description: 'Create or update page: ' , page title;
			context: context;
			check: (LeClientCheckPageExist new
					context: context;
					page: page;
					serverDatabaseId: serverDatabaseId);
			onSuccess: (LeClientApiUpdatePage new
					context: context;
					page: page;
					serverDatabaseId: serverDatabaseId);
			onNotFound: (LeClientApiCreatePage new
					context: context;
					page: page;
					serverDatabaseId: serverDatabaseId).

	createOrUpdatePage prepare
]

{ #category : #accessing }
LeClientPagePublisher >> serverDatabaseId [
	<return: #String>
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientPagePublisher >> serverDatabaseId: aString [
	serverDatabaseId := aString
]
