Class {
	#name : #GtApLepiterPagePoster,
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
GtApLepiterPagePoster >> page [
	^ page
]

{ #category : #accessing }
GtApLepiterPagePoster >> page: anObject [
	page := anObject
]

{ #category : #'api - publishing' }
GtApLepiterPagePoster >> post [
	| aPost aZnResponse |
	aZnResponse := self postPage.

	aZnResponse isSuccess
		ifFalse: [ ^ GtApLepiterPostPageFailureResponse new
				page: self page;
				serverDatabaseId: self serverDatabaseId;
				response: aZnResponse ].

	aPost := LeJsonV4 uniqueInstance deserialize: aZnResponse contents readStream.

	^ GtApLepiterPostPageSuccessResponse new
		page: self page;
		serverDatabaseId: self serverDatabaseId;
		response: aZnResponse;
		serverPage: aPost
]

{ #category : #'api - publishing' }
GtApLepiterPagePoster >> postPage [
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
GtApLepiterPagePoster >> serverDatabaseId [
	^ serverDatabaseId
]

{ #category : #accessing }
GtApLepiterPagePoster >> serverDatabaseId: anObject [
	serverDatabaseId := anObject
]
