Class {
	#name : #LeClientPublishPostResponse,
	#superclass : #Object,
	#traits : 'TLeClientResponse',
	#classTraits : 'TLeClientResponse classTrait',
	#instVars : [
		'inputPost',
		'authorName',
		'filePath',
		'response'
	],
	#category : #'LepiterClient-Client'
}

{ #category : #accessing }
LeClientPublishPostResponse >> authorName [
	^ authorName
]

{ #category : #accessing }
LeClientPublishPostResponse >> authorName: anObject [
	authorName := anObject
]

{ #category : #accessing }
LeClientPublishPostResponse >> filePath [
	^ filePath
]

{ #category : #accessing }
LeClientPublishPostResponse >> filePath: anObject [
	filePath := anObject
]

{ #category : #accessing }
LeClientPublishPostResponse >> inputPost [
	<return: #LeClientPost>
	^ inputPost
]

{ #category : #accessing }
LeClientPublishPostResponse >> inputPost: anObject [
	inputPost := anObject
]

{ #category : #testing }
LeClientPublishPostResponse >> isSuccess [
	^ self response isSuccess
]

{ #category : #accessing }
LeClientPublishPostResponse >> outputPost [
	<return: #LeClientPost>
	^ self response model
]

{ #category : #accessing }
LeClientPublishPostResponse >> response [
	^ response
]

{ #category : #accessing }
LeClientPublishPostResponse >> response: anObject [
	response := anObject
]
