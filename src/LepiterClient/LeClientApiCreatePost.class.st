Class {
	#name : #LeClientApiCreatePost,
	#superclass : #LeClientCommand,
	#instVars : [
		'page',
		'serverDatabaseId',
		'title',
		'abstract',
		'thumbnail',
		'post'
	],
	#category : #'LepiterClient-Publishing New'
}

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

	aResponse := self context client
			endpoint: LeClientEndpoints apiCreatePost;
			jsonObject: self jsonObject;
			authenticated;
			onSuccessLepiterModel;
			post.

	self addResponse: aResponse.
	^ aResponse
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
