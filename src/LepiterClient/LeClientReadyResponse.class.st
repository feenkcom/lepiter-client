Class {
	#name : #LeClientReadyResponse,
	#superclass : #Object,
	#traits : 'TLeClientResponse',
	#classTraits : 'TLeClientResponse classTrait',
	#instVars : [
		'model'
	],
	#category : #'LepiterClient-Responses'
}

{ #category : #accessing }
LeClientReadyResponse >> description [
	^ 'ready'
]

{ #category : #testing }
LeClientReadyResponse >> isSuccess [
	^ true
]

{ #category : #accessing }
LeClientReadyResponse >> model [
	"Return a domain object or nil."

	^ model
]

{ #category : #accessing }
LeClientReadyResponse >> model: anObject [
	model := anObject
]
