Class {
	#name : #LeClientApiDeletePost,
	#superclass : #LeClientCommand,
	#instVars : [
		'post'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #'api - actions' }
LeClientApiDeletePost >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	self
		ifSuccess: [ :aPreviousResponse | ^ aPreviousResponse ]
		ifFailure: [  "repeat" ]
		ifNone: [  "execute" ].

	aResponse := self context client
			endpoint: LeClientEndpoints apiDeletePost;
			jsonObject: self jsonObject;
			authenticated;
			post.

	self addResponse: aResponse.
	^ aResponse
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
