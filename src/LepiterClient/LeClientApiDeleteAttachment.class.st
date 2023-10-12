Class {
	#name : #LeClientApiDeleteAttachment,
	#superclass : #LeClientCommand,
	#instVars : [
		'snippetAttachment',
		'serverDatabaseId'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #'api - actions' }
LeClientApiDeleteAttachment >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	self
		ifSuccess: [ :aPreviousResponse | ^ aPreviousResponse ]
		ifFailure: [  "repeat" ]
		ifNone: [  "execute" ].

	aResponse := self context client
			endpoint: LeClientEndpoints apiDeleteAttachment;
			jsonObject: self jsonObject;
			authenticated;
			post.

	self addResponse: aResponse.
	^ aResponse
]

{ #category : #accessing }
LeClientApiDeleteAttachment >> jsonObject [
	^ Dictionary new
		at: #attachment put: snippetAttachment uidString;
		at: #database put: serverDatabaseId;
		yourself
]

{ #category : #'api - actions' }
LeClientApiDeleteAttachment >> prepare [
	"do nothing"

	
]

{ #category : #accessing }
LeClientApiDeleteAttachment >> serverDatabaseId [
	<return: #String>
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientApiDeleteAttachment >> serverDatabaseId: aString [
	serverDatabaseId := aString
]

{ #category : #accessing }
LeClientApiDeleteAttachment >> snippetAttachment [
	<return: #LeSnippetAttachment>
	^ snippetAttachment
]

{ #category : #accessing }
LeClientApiDeleteAttachment >> snippetAttachment: anObject [
	snippetAttachment := anObject
]