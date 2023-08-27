Class {
	#name : #GtApLepiterPublishPostResponse,
	#superclass : #Object,
	#traits : 'TGtApLepiterResponse',
	#classTraits : 'TGtApLepiterResponse classTrait',
	#instVars : [
		'inputPost',
		'authorName',
		'filePath',
		'response'
	],
	#category : #'LepiterClient-Client'
}

{ #category : #accessing }
GtApLepiterPublishPostResponse >> authorName [
	^ authorName
]

{ #category : #accessing }
GtApLepiterPublishPostResponse >> authorName: anObject [
	authorName := anObject
]

{ #category : #accessing }
GtApLepiterPublishPostResponse >> filePath [
	^ filePath
]

{ #category : #accessing }
GtApLepiterPublishPostResponse >> filePath: anObject [
	filePath := anObject
]

{ #category : #accessing }
GtApLepiterPublishPostResponse >> inputPost [
	<return: #GtApServerPost>
	^ inputPost
]

{ #category : #accessing }
GtApLepiterPublishPostResponse >> inputPost: anObject [
	inputPost := anObject
]

{ #category : #testing }
GtApLepiterPublishPostResponse >> isSuccess [
	^ self response isSuccess
]

{ #category : #accessing }
GtApLepiterPublishPostResponse >> outputPost [
	<return: #GtApServerPost>
	^ self response model
]

{ #category : #accessing }
GtApLepiterPublishPostResponse >> response [
	^ response
]

{ #category : #accessing }
GtApLepiterPublishPostResponse >> response: anObject [
	response := anObject
]
