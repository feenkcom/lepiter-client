Class {
	#name : #LeClientUpdatePage,
	#superclass : #LeClientCommand,
	#instVars : [
		'page',
		'serverDatabaseId'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientUpdatePage >> description [
	^ 'Update page: ' , self page title
]

{ #category : #'api - actions' }
LeClientUpdatePage >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	self
		ifSuccess: [ ^ self ]
		ifFailure: [  "execute again" ]
		ifNone: [  "execute" ].

	aResponse := self context client
			endpoint: LeClientEndpoints apiUpdatePage;
			lepiterObject: self lepiterObject;
			authenticated;
			onSuccessLepiterModel;
			post.

	self addResponse: aResponse.
	^ aResponse
]

{ #category : #private }
LeClientUpdatePage >> lepiterObject [
	^ {'page' -> self page.
		'database' -> self serverDatabaseId asString} asDictionary
]

{ #category : #accessing }
LeClientUpdatePage >> page [
	^ page
]

{ #category : #accessing }
LeClientUpdatePage >> page: anObject [
	page := anObject
]

{ #category : #'api - actions' }
LeClientUpdatePage >> prepare [
	"nothing to prepare"

	
]

{ #category : #accessing }
LeClientUpdatePage >> serverDatabaseId [
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientUpdatePage >> serverDatabaseId: anObject [
	serverDatabaseId := anObject
]
