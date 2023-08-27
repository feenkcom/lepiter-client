Class {
	#name : #GtApLepiterRequestError,
	#superclass : #Error,
	#instVars : [
		'client',
		'result'
	],
	#category : #'LepiterClient-Exceptions'
}

{ #category : #accessing }
GtApLepiterRequestError >> client [
	^ client
]

{ #category : #accessing }
GtApLepiterRequestError >> client: anObject [
	client := anObject
]

{ #category : #accessing }
GtApLepiterRequestError >> result [
	^ result
]

{ #category : #accessing }
GtApLepiterRequestError >> result: anObject [
	result := anObject
]
