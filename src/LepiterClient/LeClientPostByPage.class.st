Class {
	#name : #LeClientPostByPage,
	#superclass : #LeClientCommand,
	#instVars : [
		'page'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #'api - actions' }
LeClientPostByPage >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	aResponse := self context client
			endpoint: LeClientEndpoints apiPostByPage;
			authenticated;
			queryAt: #page put: page uidString;
			onSuccessLepiterModel;
			get.
	self addResponse: aResponse.
	^ aResponse
]

{ #category : #accessing }
LeClientPostByPage >> page [
	<return: #LePage>
	^ page
]

{ #category : #accessing }
LeClientPostByPage >> page: aPage [
	page := aPage
]

{ #category : #'api - actions' }
LeClientPostByPage >> prepare [
	"do nothing"

	
]
