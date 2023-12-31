Class {
	#name : #LeClientApiCreatePage,
	#superclass : #LeClientApiCommand,
	#instVars : [
		'page',
		'serverDatabaseId'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientApiCreatePage class >> endPoint [
	^ LeClientEndpoints apiCreatePage
]

{ #category : #accessing }
LeClientApiCreatePage >> description [
	^ 'Create page: ' , self page title
]

{ #category : #'api - actions' }
LeClientApiCreatePage >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	self
		ifSuccess: [ :aPreviousResponse | ^ aPreviousResponse ]
		ifFailure: [  "execute again" ]
		ifNone: [  "execute" ].

	aResponse := self context zinc
			endpoint: LeClientEndpoints apiCreatePage;
			lepiterObject: self lepiterObject;
			authenticated;
			onSuccessLepiterModel;
			post.

	self addResponse: aResponse.
	^ aResponse
]

{ #category : #'gt - extensions' }
LeClientApiCreatePage >> gtDetails [
	^ super gtDetails , {
		{ 'page' . self page }.
		{ 'server database id' . self serverDatabaseId }
	}
]

{ #category : #private }
LeClientApiCreatePage >> lepiterObject [
	^ {'page' -> self page.
		'database' -> self serverDatabaseId asString} asDictionary
]

{ #category : #accessing }
LeClientApiCreatePage >> page [
	^ page
]

{ #category : #accessing }
LeClientApiCreatePage >> page: anObject [
	page := anObject
]

{ #category : #'api - actions' }
LeClientApiCreatePage >> prepare [
	"nothing to prepare"

	
]

{ #category : #accessing }
LeClientApiCreatePage >> serverDatabaseId [
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientApiCreatePage >> serverDatabaseId: anObject [
	serverDatabaseId := anObject
]
