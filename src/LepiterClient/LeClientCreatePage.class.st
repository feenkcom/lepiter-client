Class {
	#name : #LeClientCreatePage,
	#superclass : #LeClientCommand,
	#instVars : [
		'page',
		'serverDatabaseId'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientCreatePage >> description [
	^ 'Create page: ' , self page title
]

{ #category : #'api - actions' }
LeClientCreatePage >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	self
		ifSuccess: [ ^ self ]
		ifFailure: [  "execute again" ]
		ifNone: [  "execute" ].

	aResponse := self context client
			endpoint: LeClientEndpoints apiCreatePage;
			lepiterObject: self lepiterObject;
			authenticated;
			onSuccessLepiterModel;
			post.

	self addResponse: aResponse.
	^ aResponse
]

{ #category : #private }
LeClientCreatePage >> lepiterObject [
	^ {'page' -> self page.
		'database' -> self serverDatabaseId asString} asDictionary
]

{ #category : #accessing }
LeClientCreatePage >> page [
	^ page
]

{ #category : #accessing }
LeClientCreatePage >> page: anObject [
	page := anObject
]

{ #category : #'api - actions' }
LeClientCreatePage >> prepare [
	"nothing to prepare"

	
]

{ #category : #accessing }
LeClientCreatePage >> serverDatabaseId [
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientCreatePage >> serverDatabaseId: anObject [
	serverDatabaseId := anObject
]
