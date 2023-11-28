Class {
	#name : #LeClientApiDeletePost,
	#superclass : #LeClientApiCommand,
	#instVars : [
		'post'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientApiDeletePost class >> endPoint [
	^ LeClientEndpoints apiDeletePost
]

{ #category : #'api - actions' }
LeClientApiDeletePost >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	self
		ifSuccess: [ :aPreviousResponse | ^ aPreviousResponse ]
		ifFailure: [  "repeat" ]
		ifNone: [  "execute" ].

	aResponse := self context zinc
			endpoint: LeClientEndpoints apiDeletePost;
			jsonObject: self jsonObject;
			authenticated;
			post.

	self addResponse: aResponse.
	^ aResponse
]

{ #category : #'gt - extensions' }
LeClientApiDeletePost >> gtDetails [
	^ super gtDetails , {
		{ 'post' . self post }
	}
]

{ #category : #accessing }
LeClientApiDeletePost >> jsonObject [
	^ Dictionary new
		at: #post put: post uuid asString;
		yourself
]

{ #category : #accessing }
LeClientApiDeletePost >> post [
	<return: #LeClientPost>
	^ post
]

{ #category : #accessing }
LeClientApiDeletePost >> post: aClientPost [
	post := aClientPost
]

{ #category : #'api - actions' }
LeClientApiDeletePost >> prepare [
	"do nothing"

	
]
