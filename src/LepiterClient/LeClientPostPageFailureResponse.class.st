Class {
	#name : #LeClientPostPageFailureResponse,
	#superclass : #Object,
	#traits : 'TGtApLepiterResponse',
	#classTraits : 'TGtApLepiterResponse classTrait',
	#instVars : [
		'page',
		'serverDatabaseId',
		'response'
	],
	#category : #'LepiterClient-Publishing'
}

{ #category : #accessing }
LeClientPostPageFailureResponse >> page [
	^ page
]

{ #category : #accessing }
LeClientPostPageFailureResponse >> page: anObject [
	page := anObject
]

{ #category : #accessing }
LeClientPostPageFailureResponse >> response [
	^ response
]

{ #category : #accessing }
LeClientPostPageFailureResponse >> response: anObject [
	response := anObject
]

{ #category : #accessing }
LeClientPostPageFailureResponse >> serverDatabaseId [
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientPostPageFailureResponse >> serverDatabaseId: anObject [
	serverDatabaseId := anObject
]
