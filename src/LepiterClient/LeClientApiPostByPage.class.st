Class {
	#name : #LeClientApiPostByPage,
	#superclass : #LeClientApiCommand,
	#instVars : [
		'page'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientApiPostByPage class >> endPoint [
	^ LeClientEndpoints apiPostByPage
]

{ #category : #accessing }
LeClientApiPostByPage >> description [
	^ 'Get post by page: ' , (page ifNotNil: #title ifNil: [ '<undefined>' ])
]

{ #category : #'api - actions' }
LeClientApiPostByPage >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	aResponse := self context zinc
			endpoint: LeClientEndpoints apiPostByPage;
			authenticated;
			queryAt: #page put: page uidString;
			onSuccessLepiterModel;
			get.
	self addResponse: aResponse.
	^ aResponse
]

{ #category : #'gt - extensions' }
LeClientApiPostByPage >> gtDetails [
	^ super gtDetails , {
		{ 'page' . self page }
	}
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
