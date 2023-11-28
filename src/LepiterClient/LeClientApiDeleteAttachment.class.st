Class {
	#name : #LeClientApiDeleteAttachment,
	#superclass : #LeClientApiCommand,
	#instVars : [
		'snippetAttachment',
		'serverDatabaseId'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientApiDeleteAttachment class >> endPoint [
	^ LeClientEndpoints apiDeleteAttachment
]

{ #category : #'api - actions' }
LeClientApiDeleteAttachment >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	self
		ifSuccess: [ :aPreviousResponse | ^ aPreviousResponse ]
		ifFailure: [  "repeat" ]
		ifNone: [  "execute" ].

	aResponse := self context zinc
			endpoint: LeClientEndpoints apiDeleteAttachment;
			jsonObject: self jsonObject;
			authenticated;
			post.

	self addResponse: aResponse.
	^ aResponse
]

{ #category : #'gt - extensions' }
LeClientApiDeleteAttachment >> gtDetails [
	^ super gtDetails , {
		{ 'snippet attachment' . self snippetAttachment }.
		{ 'server database id' . self serverDatabaseId }
	}
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
