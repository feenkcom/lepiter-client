Class {
	#name : #LeClientCreateRenderedPostResponse,
	#superclass : #Object,
	#traits : 'TGtApLepiterResponse',
	#classTraits : 'TGtApLepiterResponse classTrait',
	#instVars : [
		'response',
		'filePath',
		'serverPost'
	],
	#category : #'LepiterClient-Client'
}

{ #category : #accessing }
LeClientCreateRenderedPostResponse >> filePath [
	<return: #RelativePath>
	^ filePath
]

{ #category : #accessing }
LeClientCreateRenderedPostResponse >> filePath: anObject [
	filePath := anObject
]

{ #category : #testing }
LeClientCreateRenderedPostResponse >> isSuccess [
	^ self response isSuccess
]

{ #category : #printing }
LeClientCreateRenderedPostResponse >> printOn: aStream [
	super printOn: aStream.

	aStream nextPut: $(.
	aStream print: self response.
	aStream nextPut: $)
]

{ #category : #accessing }
LeClientCreateRenderedPostResponse >> response [
	^ response
]

{ #category : #accessing }
LeClientCreateRenderedPostResponse >> response: anObject [
	response := anObject
]

{ #category : #accessing }
LeClientCreateRenderedPostResponse >> serverPost [
	^ serverPost
]

{ #category : #accessing }
LeClientCreateRenderedPostResponse >> serverPost: anObject [
	serverPost := anObject
]
