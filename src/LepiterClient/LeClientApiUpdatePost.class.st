Class {
	#name : #LeClientApiUpdatePost,
	#superclass : #LeClientApiCommand,
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
LeClientApiUpdatePost class >> endPoint [
	^ LeClientEndpoints apiUpdatePost
]

{ #category : #accessing }
LeClientApiUpdatePost >> description [
	^ 'Update post: ' , self post title
]

{ #category : #'api - actions' }
LeClientApiUpdatePost >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	self
		ifSuccess: [ :aPreviousResponse | ^ aPreviousResponse ]
		ifFailure: [  "execute again" ]
		ifNone: [  "execute" ].

	aResponse := self context zinc
			endpoint: LeClientEndpoints apiUpdatePost;
			jsonObject: self jsonObject;
			authenticated;
			onSuccessLepiterModel;
			post.

	self addResponse: aResponse.
	^ aResponse
]

{ #category : #'gt - extensions' }
LeClientApiUpdatePost >> gtDetails [
	^ super gtDetails , {
		{ 'post' . self post }.
		{ 'post id' . self postId ifNil: [ '' ] }.
		{ 'title' . self post title }.
		{ 'abstract' . self post abstract }.
		{ 'thumbnail' . self post thumbnail }.
		{ 'page' . self page }.
		{ 'server database id' . self serverDatabaseId }
	}
]

{ #category : #private }
LeClientApiUpdatePost >> jsonObject [
	^ {'post' -> self postId.
		'title' -> post title.
		'abstract' -> post abstract.
		'thumbnail' -> post thumbnail} asDictionary
]

{ #category : #accessing }
LeClientApiUpdatePost >> page [
	^ page
]

{ #category : #accessing }
LeClientApiUpdatePost >> page: anObject [
	page := anObject
]

{ #category : #accessing }
LeClientApiUpdatePost >> post [
	<return: #LeClientPost>
	^ post
]

{ #category : #'api - convenience' }
LeClientApiUpdatePost >> post: aClientPost [
	post := aClientPost
]

{ #category : #accessing }
LeClientApiUpdatePost >> postId [
	^ self post uuid ifNotNil: #asString
]

{ #category : #accessing }
LeClientApiUpdatePost >> postId: anUUID [
	self
		assert: [ anUUID isKindOf: UUID ]
		description: [ 'Post ID must be an UUID instance: {1}' format: {anUUID} ].
	^ self post uuid: anUUID
]

{ #category : #'api - actions' }
LeClientApiUpdatePost >> prepare [
	"nothing to prepare"

	
]

{ #category : #accessing }
LeClientApiUpdatePost >> serverDatabaseId [
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientApiUpdatePost >> serverDatabaseId: anObject [
	serverDatabaseId := anObject
]
