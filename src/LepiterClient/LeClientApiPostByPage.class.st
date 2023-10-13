Class {
	#name : #LeClientApiPostByPage,
	#superclass : #LeClientCommand,
	#instVars : [
		'page'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientApiPostByPage >> description [
	^ 'Get post by page: ' , (page ifNotNil: #title ifNil: [ '<undefined>' ])
]

{ #category : #'api - actions' }
LeClientApiPostByPage >> execute [
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
LeClientApiPostByPage >> page [
	<return: #LePage>
	^ page
]

{ #category : #accessing }
LeClientApiPostByPage >> page: aPage [
	page := aPage
]

{ #category : #'api - actions' }
LeClientApiPostByPage >> prepare [
	"do nothing"

	
]
