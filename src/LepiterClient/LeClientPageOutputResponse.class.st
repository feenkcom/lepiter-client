Class {
	#name : #LeClientPageOutputResponse,
	#superclass : #Object,
	#traits : 'TLeClientResponse',
	#classTraits : 'TLeClientResponse classTrait',
	#instVars : [
		'resource'
	],
	#category : #'LepiterClient-Responses'
}

{ #category : #accessing }
LeClientPageOutputResponse >> contents [
	<return: #String>
	^ resource contents
]

{ #category : #testing }
LeClientPageOutputResponse >> isSuccess [
	^ true
]

{ #category : #accessing }
LeClientPageOutputResponse >> model [
	"Return a domain object or nil."

	^ self resource
]

{ #category : #accessing }
LeClientPageOutputResponse >> resource [
	<return: #LeExportPageOutputResource>
	^ resource
]

{ #category : #accessing }
LeClientPageOutputResponse >> resource: anObject [
	resource := anObject
]
