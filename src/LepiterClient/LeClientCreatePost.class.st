Class {
	#name : #LeClientCreatePost,
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
LeClientCreatePost >> description [
	^ 'Create post: ' , self post title
]

{ #category : #'api - actions' }
LeClientCreatePost >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	self
		ifSuccess: [ ^ self ]
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
LeClientCreatePost >> jsonObject [
	^ {'database' -> serverDatabaseId asString.
		'page' -> post page asString.
		'title' -> post title.
		'abstract' -> post abstract.
		'thumbnail' -> post thumbnail} asDictionary
]

{ #category : #accessing }
LeClientCreatePost >> page [
	^ page
]

{ #category : #accessing }
LeClientCreatePost >> page: anObject [
	page := anObject
]

{ #category : #accessing }
LeClientCreatePost >> post [
	^ post
]

{ #category : #'api - convenience' }
LeClientCreatePost >> post: aClientPost [
	post := aClientPost
]

{ #category : #'api - actions' }
LeClientCreatePost >> prepare [
	"nothing to prepare"

	
]

{ #category : #accessing }
LeClientCreatePost >> serverDatabaseId [
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientCreatePost >> serverDatabaseId: anObject [
	serverDatabaseId := anObject
]
