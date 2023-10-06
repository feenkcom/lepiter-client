Class {
	#name : #LeClientUpdatePost,
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
LeClientUpdatePost >> description [
	^ 'Update post: ' , self post title
]

{ #category : #'api - actions' }
LeClientUpdatePost >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	self
		ifSuccess: [ ^ self ]
		ifFailure: [  "execute again" ]
		ifNone: [  "execute" ].

	aResponse := self context client
			endpoint: LeClientEndpoints apiUpdatePost;
			jsonObject: self jsonObject;
			authenticated;
			onSuccessLepiterModel;
			post.

	self addResponse: aResponse.
	^ aResponse
]

{ #category : #private }
LeClientUpdatePost >> jsonObject [
	^ {'database' -> serverDatabaseId asString.
		'page' -> post page asString.
		'title' -> post title.
		'abstract' -> post abstract.
		'thumbnail' -> post thumbnail} asDictionary
]

{ #category : #accessing }
LeClientUpdatePost >> page [
	^ page
]

{ #category : #accessing }
LeClientUpdatePost >> page: anObject [
	page := anObject
]

{ #category : #accessing }
LeClientUpdatePost >> post [
	^ post
]

{ #category : #'api - convenience' }
LeClientUpdatePost >> post: aClientPost [
	post := aClientPost
]

{ #category : #'api - actions' }
LeClientUpdatePost >> prepare [
	"nothing to prepare"

	
]

{ #category : #accessing }
LeClientUpdatePost >> serverDatabaseId [
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientUpdatePost >> serverDatabaseId: anObject [
	serverDatabaseId := anObject
]
