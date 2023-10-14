Class {
	#name : #LeClientApiCreateRenderedPost,
	#superclass : #LeClientCommand,
	#instVars : [
		'post',
		'filePath',
		'contents',
		'figures'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientApiCreateRenderedPost >> contents [
	^ contents
]

{ #category : #accessing }
LeClientApiCreateRenderedPost >> contents: anObject [
	contents := anObject
]

{ #category : #accessing }
LeClientApiCreateRenderedPost >> description [
	^ 'Create rendered post: ' , self post title
]

{ #category : #'api - actions' }
LeClientApiCreateRenderedPost >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	self
		ifSuccess: [ :aPreviousResponse | ^ aPreviousResponse ]
		ifFailure: [  "execute again" ]
		ifNone: [  "execute" ].

	aResponse := self context zinc
			endpoint: LeClientEndpoints apiCreateRenderedPost;
			jsonObject: self jsonObject;
			authenticated;
			onSuccessLepiterModel: [ :aClientPost | 
				LeClientRenderedPost new
					post: aClientPost;
					filePath: filePath ];
			post.

	self addResponse: aResponse.
	^ aResponse
]

{ #category : #accessing }
LeClientApiCreateRenderedPost >> figures [
	^ figures
]

{ #category : #accessing }
LeClientApiCreateRenderedPost >> figures: anObject [
	figures := anObject
]

{ #category : #accessing }
LeClientApiCreateRenderedPost >> filePath [
	<return: #String>
	^ filePath
]

{ #category : #accessing }
LeClientApiCreateRenderedPost >> filePath: anObject [
	filePath := anObject
]

{ #category : #accessing }
LeClientApiCreateRenderedPost >> jsonObject [
	^ Dictionary new
		at: #post put: post uuid asString;
		at: #filePath put: filePath;
		at: #contents put: contents;
		at: #figures put: figures;
		yourself
]

{ #category : #accessing }
LeClientApiCreateRenderedPost >> post [
	<return: #LeClientPost>
	^ post
]

{ #category : #accessing }
LeClientApiCreateRenderedPost >> post: aPost [
	post := aPost
]

{ #category : #'api - actions' }
LeClientApiCreateRenderedPost >> prepare [
	"do nothing"

	
]
