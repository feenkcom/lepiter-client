Class {
	#name : #LeClientPagePoster,
	#superclass : #Object,
	#traits : 'TGtApLepiterWithClient',
	#classTraits : 'TGtApLepiterWithClient classTrait',
	#instVars : [
		'page',
		'serverDatabaseId'
	],
	#category : #'LepiterClient-Publishing'
}

{ #category : #accessing }
LeClientPagePoster >> page [
	^ page
]

{ #category : #accessing }
LeClientPagePoster >> page: anObject [
	page := anObject
]

{ #category : #'api - publishing' }
LeClientPagePoster >> post [
	| aPost aZnResponse |
	aZnResponse := self postPage.

	aZnResponse isSuccess
		ifFalse: [ ^ LeClientPostPageFailureResponse new
				page: self page;
				serverDatabaseId: self serverDatabaseId;
				response: aZnResponse ].

	aPost := LeJsonV4 uniqueInstance deserialize: aZnResponse contents readStream.

	^ LeClientPostPageSuccessResponse new
		page: self page;
		serverDatabaseId: self serverDatabaseId;
		response: aZnResponse;
		serverPage: aPost
]

{ #category : #'api - publishing' }
LeClientPagePoster >> postPage [
	^ ZnClient new beOneShot
		url: self server , '/api/createPage';
		entity: (ZnEntity
				json: (LeJsonV4 uniqueInstance
						serialize: {'page' -> self page.
								'database' -> self serverDatabaseId asString} asDictionary));
		setBearerAuthentication: self token;
		post;
		response
]

{ #category : #accessing }
LeClientPagePoster >> serverDatabaseId [
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientPagePoster >> serverDatabaseId: anObject [
	serverDatabaseId := anObject
]
