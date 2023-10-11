Class {
	#name : #LeClientCheckPageExist,
	#superclass : #LeClientCommand,
	#instVars : [
		'page',
		'serverDatabaseId'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientCheckPageExist >> description [
	^ 'Check page exists: ' , self page title
]

{ #category : #'api - actions' }
LeClientCheckPageExist >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	aResponse := self context client
			endpoint: LeClientEndpoints apiPage;
			authenticated;
			queryAt: #page put: page uidString;
			queryAt: #database put: serverDatabaseId;
			onSuccessLepiterModel;
			get.
	aResponse := LeClientModelExistResponse new subresponse: aResponse.
	self addResponse: aResponse.

	^ aResponse
]

{ #category : #accessing }
LeClientCheckPageExist >> page [
	<return: #LePage>
	^ page
]

{ #category : #accessing }
LeClientCheckPageExist >> page: aPage [
	page := aPage
]

{ #category : #'api - actions' }
LeClientCheckPageExist >> prepare [
	"nothing to do"

	
]

{ #category : #accessing }
LeClientCheckPageExist >> serverDatabaseId [
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientCheckPageExist >> serverDatabaseId: anObject [
	serverDatabaseId := anObject
]