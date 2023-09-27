Class {
	#name : #LeClientClientExportPageSuccessResponse,
	#superclass : #Object,
	#traits : 'TGtApLepiterResponse',
	#classTraits : 'TGtApLepiterResponse classTrait',
	#instVars : [
		'serverPage',
		'clientPage',
		'serverDatabaseId',
		'responses'
	],
	#category : #'LepiterClient-Publishing'
}

{ #category : #accessing }
LeClientClientExportPageSuccessResponse >> clientPage [
	^ clientPage
]

{ #category : #accessing }
LeClientClientExportPageSuccessResponse >> clientPage: anObject [
	clientPage := anObject
]

{ #category : #testing }
LeClientClientExportPageSuccessResponse >> isSuccess [
	^ true
]

{ #category : #accessing }
LeClientClientExportPageSuccessResponse >> responses [
	^ responses
]

{ #category : #accessing }
LeClientClientExportPageSuccessResponse >> responses: anObject [
	responses := anObject
]

{ #category : #accessing }
LeClientClientExportPageSuccessResponse >> serverDatabaseId [
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientClientExportPageSuccessResponse >> serverDatabaseId: anObject [
	serverDatabaseId := anObject
]

{ #category : #accessing }
LeClientClientExportPageSuccessResponse >> serverPage [
	^ serverPage
]

{ #category : #accessing }
LeClientClientExportPageSuccessResponse >> serverPage: anObject [
	serverPage := anObject
]