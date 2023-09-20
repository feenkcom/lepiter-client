Class {
	#name : #GtApLepiterCreateRenderedPostResponse,
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
GtApLepiterCreateRenderedPostResponse >> filePath [
	<return: #RelativePath>
	^ filePath
]

{ #category : #accessing }
GtApLepiterCreateRenderedPostResponse >> filePath: anObject [
	filePath := anObject
]

{ #category : #testing }
GtApLepiterCreateRenderedPostResponse >> isSuccess [
	^ self response isSuccess
]

{ #category : #printing }
GtApLepiterCreateRenderedPostResponse >> printOn: aStream [
	super printOn: aStream.

	aStream nextPut: $(.
	aStream print: self response.
	aStream nextPut: $)
]

{ #category : #accessing }
GtApLepiterCreateRenderedPostResponse >> response [
	^ response
]

{ #category : #accessing }
GtApLepiterCreateRenderedPostResponse >> response: anObject [
	response := anObject
]

{ #category : #accessing }
GtApLepiterCreateRenderedPostResponse >> serverPost [
	^ serverPost
]

{ #category : #accessing }
GtApLepiterCreateRenderedPostResponse >> serverPost: anObject [
	serverPost := anObject
]
