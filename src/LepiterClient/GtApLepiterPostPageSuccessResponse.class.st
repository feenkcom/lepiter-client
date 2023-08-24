Class {
	#name : #GtApLepiterPostPageSuccessResponse,
	#superclass : #Object,
	#traits : 'TGtApLepiterResponse',
	#classTraits : 'TGtApLepiterResponse classTrait',
	#instVars : [
		'page',
		'serverDatabaseId',
		'response',
		'serverPage'
	],
	#category : #'LepiterClient-Publishing'
}

{ #category : #testing }
GtApLepiterPostPageSuccessResponse >> isSuccess [
	^ true
]

{ #category : #accessing }
GtApLepiterPostPageSuccessResponse >> page [
	^ page
]

{ #category : #accessing }
GtApLepiterPostPageSuccessResponse >> page: anObject [
	page := anObject
]

{ #category : #accessing }
GtApLepiterPostPageSuccessResponse >> response [
	^ response
]

{ #category : #accessing }
GtApLepiterPostPageSuccessResponse >> response: anObject [
	response := anObject
]

{ #category : #accessing }
GtApLepiterPostPageSuccessResponse >> serverDatabaseId [
	^ serverDatabaseId
]

{ #category : #accessing }
GtApLepiterPostPageSuccessResponse >> serverDatabaseId: anObject [
	serverDatabaseId := anObject
]

{ #category : #accessing }
GtApLepiterPostPageSuccessResponse >> serverPage [
	^ serverPage
]

{ #category : #accessing }
GtApLepiterPostPageSuccessResponse >> serverPage: anObject [
	serverPage := anObject
]
