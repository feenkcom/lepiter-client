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
