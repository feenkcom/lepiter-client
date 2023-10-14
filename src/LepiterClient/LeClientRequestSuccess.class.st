Class {
	#name : #LeClientRequestSuccess,
	#superclass : #Object,
	#traits : 'TLeClientResponse - {#description. #subresponses} + TLeClientZincResponse + TLeClientWithSubresponses',
	#classTraits : 'TLeClientResponse classTrait + TLeClientZincResponse classTrait + TLeClientWithSubresponses classTrait',
	#instVars : [
		'model',
		'response',
		'request'
	],
	#category : #'LepiterClient-Responses'
}

{ #category : #'gt - extensions' }
LeClientRequestSuccess >> hasResponse [
	<return: #Boolean>
	^ true
]

{ #category : #testing }
LeClientRequestSuccess >> isSuccess [
	^ true
]

{ #category : #accessing }
LeClientRequestSuccess >> model [
	^ model
]

{ #category : #accessing }
LeClientRequestSuccess >> model: anObject [
	model := anObject
]

{ #category : #accessing }
LeClientRequestSuccess >> request [
	<return: #ZnRequest>
	^ request
]

{ #category : #accessing }
LeClientRequestSuccess >> request: anObject [
	request := anObject
]

{ #category : #accessing }
LeClientRequestSuccess >> response [
	<return: #ZnResponse>
	^ response
]

{ #category : #accessing }
LeClientRequestSuccess >> response: anObject [
	response := anObject
]
