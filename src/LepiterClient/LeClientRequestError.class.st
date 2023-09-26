Class {
	#name : #LeClientRequestError,
	#superclass : #Error,
	#instVars : [
		'client',
		'result'
	],
	#category : #'LepiterClient-Exceptions'
}

{ #category : #accessing }
LeClientRequestError >> client [
	^ client
]

{ #category : #accessing }
LeClientRequestError >> client: anObject [
	client := anObject
]

{ #category : #accessing }
LeClientRequestError >> result [
	^ result
]

{ #category : #accessing }
LeClientRequestError >> result: anObject [
	result := anObject
]
