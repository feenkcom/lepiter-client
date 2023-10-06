Class {
	#name : #LeClientApiUpdatePage,
	#superclass : #LeClientCommand,
	#instVars : [
		'page',
		'serverDatabaseId'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientApiUpdatePage >> description [
	^ 'Update page: ' , self page title
]

{ #category : #'api - actions' }
LeClientApiUpdatePage >> execute [
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
LeClientApiUpdatePage >> lepiterObject [
	^ {'page' -> self page.
		'database' -> self serverDatabaseId asString} asDictionary
]

{ #category : #accessing }
LeClientApiUpdatePage >> page [
	^ page
]

{ #category : #accessing }
LeClientApiUpdatePage >> page: anObject [
	page := anObject
]

{ #category : #'api - actions' }
LeClientApiUpdatePage >> prepare [
	"nothing to prepare"

	
]

{ #category : #accessing }
LeClientApiUpdatePage >> serverDatabaseId [
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientApiUpdatePage >> serverDatabaseId: anObject [
	serverDatabaseId := anObject
]
