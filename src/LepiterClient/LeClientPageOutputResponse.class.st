Class {
	#name : #LeClientPageOutputResponse,
	#superclass : #LeClientResponse,
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

{ #category : #accessing }
LeClientPageOutputResponse >> description [
	^ 'ready'
]

{ #category : #accessing }
LeClientPageOutputResponse >> filePath [
	<return: #String>
	^ resource pageLink fileName
]

{ #category : #'gt - extensions' }
LeClientPageOutputResponse >> gtDetails [
	^ super gtDetails , {
		{ 'resource' . self resource }
	}
]

{ #category : #testing }
LeClientPageOutputResponse >> isSuccess [
	^ true
]

{ #category : #accessing }
LeClientPageOutputResponse >> model [
	"Return a domain object or nil."

	<return: #LeExportPageOutputResource>
	^ resource
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
