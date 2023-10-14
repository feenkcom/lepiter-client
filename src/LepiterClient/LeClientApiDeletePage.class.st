Class {
	#name : #LeClientApiDeletePage,
	#superclass : #LeClientCommand,
	#instVars : [
		'page'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #'api - actions' }
LeClientApiDeletePage >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	self
		ifSuccess: [ :aPreviousResponse | ^ aPreviousResponse ]
		ifFailure: [  "repeat" ]
		ifNone: [  "execute" ].

	aResponse := self context zinc
			endpoint: LeClientEndpoints apiDeletePage;
			jsonObject: self jsonObject;
			authenticated;
			post.

	self addResponse: aResponse.
	^ aResponse
]

{ #category : #accessing }
LeClientApiDeletePage >> jsonObject [
	^ Dictionary new
		at: #page put: page uidString;
		yourself
]

{ #category : #accessing }
LeClientApiDeletePage >> page [
	<return: #LePage>
	^ page
]

{ #category : #accessing }
LeClientApiDeletePage >> page: aPage [
	page := aPage
]

{ #category : #'api - actions' }
LeClientApiDeletePage >> prepare [
	"do nothing"

	
]
