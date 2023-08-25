Class {
	#name : #GtApLepiterClientExportPageSuccessResponse,
	#superclass : #Object,
	#instVars : [
		'serverPage',
		'clientPage',
		'serverDatabaseId',
		'responses'
	],
	#category : #'LepiterClient-Publishing'
}

{ #category : #accessing }
GtApLepiterClientExportPageSuccessResponse >> clientPage [
	^ clientPage
]

{ #category : #accessing }
GtApLepiterClientExportPageSuccessResponse >> clientPage: anObject [
	clientPage := anObject
]

{ #category : #accessing }
GtApLepiterClientExportPageSuccessResponse >> responses [
	^ responses
]

{ #category : #accessing }
GtApLepiterClientExportPageSuccessResponse >> responses: anObject [
	responses := anObject
]

{ #category : #accessing }
GtApLepiterClientExportPageSuccessResponse >> serverDatabaseId [
	^ serverDatabaseId
]

{ #category : #accessing }
GtApLepiterClientExportPageSuccessResponse >> serverDatabaseId: anObject [
	serverDatabaseId := anObject
]

{ #category : #accessing }
GtApLepiterClientExportPageSuccessResponse >> serverPage [
	^ serverPage
]

{ #category : #accessing }
GtApLepiterClientExportPageSuccessResponse >> serverPage: anObject [
	serverPage := anObject
]
