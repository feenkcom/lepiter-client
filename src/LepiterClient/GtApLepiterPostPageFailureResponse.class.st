Class {
	#name : #GtApLepiterPostPageFailureResponse,
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
GtApLepiterPostPageFailureResponse >> page [
	^ page
]

{ #category : #accessing }
GtApLepiterPostPageFailureResponse >> page: anObject [
	page := anObject
]

{ #category : #accessing }
GtApLepiterPostPageFailureResponse >> response [
	^ response
]

{ #category : #accessing }
GtApLepiterPostPageFailureResponse >> response: anObject [
	response := anObject
]

{ #category : #accessing }
GtApLepiterPostPageFailureResponse >> serverDatabaseId [
	^ serverDatabaseId
]

{ #category : #accessing }
GtApLepiterPostPageFailureResponse >> serverDatabaseId: anObject [
	serverDatabaseId := anObject
]
