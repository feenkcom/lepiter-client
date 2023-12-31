Class {
	#name : #LeClientApiPublishPost,
	#superclass : #LeClientApiCommand,
	#instVars : [
		'post',
		'filePath',
		'authorName'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientApiPublishPost class >> endPoint [
	^ LeClientEndpoints apiPublishPost
]

{ #category : #accessing }
LeClientApiPublishPost >> authorName [
	^ authorName
]

{ #category : #accessing }
LeClientApiPublishPost >> authorName: anObject [
	authorName := anObject
]

{ #category : #accessing }
LeClientApiPublishPost >> description [
	^ 'Publish rendered post: '
		, (self post ifNotNil: #title ifNil: [ '<undefined>' ])
]

{ #category : #'api - responses' }
LeClientApiPublishPost >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	self
		ifSuccess: [ :aPreviousResponse | ^ aPreviousResponse ]
		ifFailure: [  "execute again" ]
		ifNone: [  "execute" ].

	aResponse := self context zinc
			endpoint: LeClientEndpoints apiPublishPost;
			jsonObject: self jsonObject;
			authenticated;
			onSuccessLepiterModel;
			post.

	self addResponse: aResponse.
	^ aResponse
]

{ #category : #accessing }
LeClientApiPublishPost >> filePath [
	<return: #RelativePath>
	^ filePath
]

{ #category : #accessing }
LeClientApiPublishPost >> filePath: aRelativePath [
	filePath := aRelativePath
]

{ #category : #'gt - extensions' }
LeClientApiPublishPost >> gtDetails [
	^ super gtDetails , {
		{ 'post' . post }.
		{ 'post id' . post uuid asString . post uuid }.
		{ 'file' . filePath pathString . filePath }.
		{ 'author' . authorName }
	}
]

{ #category : #private }
LeClientApiPublishPost >> jsonObject [
	^ Dictionary new
		at: #post put: post uuid asString;
		at: #file put: filePath pathString;
		at: #author put: authorName;
		yourself
]

{ #category : #accessing }
LeClientApiPublishPost >> post [
	<return: #LeClientPost>
	^ post
]

{ #category : #accessing }
LeClientApiPublishPost >> post: aClientPost [
	self
		assert: [ aClientPost isKindOf: LeClientPost ]
		description: [ 'Post must be kind of LeClientPost: {1}' format: {aClientPost} ].
	post := aClientPost
]

{ #category : #'api - responses' }
LeClientApiPublishPost >> prepare [
	"do nothing"

	
]
