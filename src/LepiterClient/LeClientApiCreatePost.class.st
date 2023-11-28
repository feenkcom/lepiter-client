Class {
	#name : #LeClientApiCreatePost,
	#superclass : #LeClientApiCommand,
	#instVars : [
		'serverDatabaseId',
		'post',
		'page'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientApiCreatePost class >> endPoint [
	^ LeClientEndpoints apiCreatePost
]

{ #category : #accessing }
LeClientApiCreatePost >> description [
	^ 'Create post: ' , self post title
]

{ #category : #'api - actions' }
LeClientApiCreatePost >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	self
		ifSuccess: [ :aPreviousResponse | ^ aPreviousResponse ]
		ifFailure: [  "execute again" ]
		ifNone: [  "execute" ].

	aResponse := self context zinc
			endpoint: LeClientEndpoints apiCreatePost;
			jsonObject: self jsonObject;
			authenticated;
			onSuccessLepiterModel;
			post.

	self addResponse: aResponse.
	^ aResponse
]

{ #category : #'gt - extensions' }
LeClientApiCreatePost >> gtDetails [
	^ super gtDetails , {
		{ 'post' . self post }.
		{ 'post page' . self post page asString . self post page }.
		{ 'title' . self post title }.
		{ 'abstract' . self post abstract }.
		{ 'thumbnail' . self post thumbnail }.
		{ 'server database id' . self serverDatabaseId }.
		{ 'page' . self page }
	}
]

{ #category : #private }
LeClientApiCreatePost >> jsonObject [
	^ {'database' -> serverDatabaseId asString.
		'page' -> post page asString.
		'title' -> post title.
		'abstract' -> post abstract.
		'thumbnail' -> post thumbnail} asDictionary
]

{ #category : #accessing }
LeClientApiCreatePost >> page [
	^ page
]

{ #category : #accessing }
LeClientApiCreatePost >> page: anObject [
	page := anObject
]

{ #category : #accessing }
LeClientApiCreatePost >> post [
	^ post
]

{ #category : #'api - convenience' }
LeClientApiCreatePost >> post: aClientPost [
	post := aClientPost
]

{ #category : #'api - actions' }
LeClientApiCreatePost >> prepare [
	"nothing to prepare"

	
]

{ #category : #accessing }
LeClientApiCreatePost >> serverDatabaseId [
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientApiCreatePost >> serverDatabaseId: anObject [
	serverDatabaseId := anObject
]
