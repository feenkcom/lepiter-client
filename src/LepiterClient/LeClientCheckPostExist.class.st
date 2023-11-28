Class {
	#name : #LeClientCheckPostExist,
	#superclass : #LeClientCompositeCommand,
	#instVars : [
		'page',
		'getPost'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientCheckPostExist >> description [
	^ 'Check post exists: ' , self page title
]

{ #category : #'api - actions' }
LeClientCheckPostExist >> execute [
	<return: #TLeClientResponse>
	| aGetResponse aResponse |
	self
		assert: [ page isNotNil ]
		description: [ 'Page is not defined' ].

	aGetResponse := getPost execute.
	aResponse := LeClientModelExistResponse new subresponse: aGetResponse.
	self addResponse: aResponse.

	^ aResponse
]

{ #category : #'gt - extensions' }
LeClientCheckPostExist >> gtDetails [
	^ super gtDetails , {
		{ 'page' . self page }.
		{ '1. get post'
			. getPost classAndDescription
			. getPost }
	}
]

{ #category : #accessing }
LeClientCheckPostExist >> page [
	<return: #LePage>
	^ page
]

{ #category : #accessing }
LeClientCheckPostExist >> page: anObject [
	page := anObject
]

{ #category : #accessing }
LeClientCheckPostExist >> postId [
	<return: #UUID or: nil>
	^ self
		ifSuccess: [ :aResponse | aResponse model uuid ]
		ifFailure: [ nil ]
		ifNone: [ nil ]
]

{ #category : #'api - actions' }
LeClientCheckPostExist >> prepare [
	getPost ifNotNil: [ ^ self ].
	getPost := LeClientApiPostByPage new
			context: context;
			page: page
]
