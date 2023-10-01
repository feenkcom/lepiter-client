Class {
	#name : #LeClientPostPageSuccessResponse,
	#superclass : #Object,
	#traits : 'TLeClientResponse',
	#classTraits : 'TLeClientResponse classTrait',
	#instVars : [
		'page',
		'serverDatabaseId',
		'response',
		'serverPage'
	],
	#category : #'LepiterClient-Publishing'
}

{ #category : #testing }
LeClientPostPageSuccessResponse >> isSuccess [
	^ true
]

{ #category : #accessing }
LeClientPostPageSuccessResponse >> page [
	^ page
]

{ #category : #accessing }
LeClientPostPageSuccessResponse >> page: anObject [
	page := anObject
]

{ #category : #accessing }
LeClientPostPageSuccessResponse >> response [
	^ response
]

{ #category : #accessing }
LeClientPostPageSuccessResponse >> response: anObject [
	response := anObject
]

{ #category : #accessing }
LeClientPostPageSuccessResponse >> serverDatabaseId [
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientPostPageSuccessResponse >> serverDatabaseId: anObject [
	serverDatabaseId := anObject
]

{ #category : #accessing }
LeClientPostPageSuccessResponse >> serverPage [
	^ serverPage
]

{ #category : #accessing }
LeClientPostPageSuccessResponse >> serverPage: anObject [
	serverPage := anObject
]
