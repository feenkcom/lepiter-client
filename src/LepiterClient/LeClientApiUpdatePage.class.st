Class {
	#name : #LeClientApiUpdatePage,
	#superclass : #LeClientApiCommand,
	#instVars : [
		'page',
		'serverDatabaseId'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientApiUpdatePage class >> endPoint [
	^ LeClientEndpoints apiUpdatePage
]

{ #category : #accessing }
LeClientApiUpdatePage >> description [
	^ 'Update page: ' , self page title
]

{ #category : #'api - actions' }
LeClientApiUpdatePage >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	self
		ifSuccess: [ :aPreviousResponse | ^ aPreviousResponse ]
		ifFailure: [  "execute again" ]
		ifNone: [  "execute" ].

	aResponse := self context zinc
			endpoint: LeClientEndpoints apiUpdatePage;
			lepiterObject: self lepiterObject;
			authenticated;
			onSuccessLepiterModel;
			post.

	self addResponse: aResponse.
	^ aResponse
]

{ #category : #'gt - extensions' }
LeClientApiUpdatePage >> gtDetails [
	^ super gtDetails , {
		{ 'page' . self page }.
		{ 'server database id' . self serverDatabaseId }
	}
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
