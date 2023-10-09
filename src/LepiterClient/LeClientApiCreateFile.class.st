Class {
	#name : #LeClientApiCreateFile,
	#superclass : #LeClientCommand,
	#instVars : [
		'snippetAttachment'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientApiCreateFile >> blob [
	<return: #String or: nil>
	^ self
		ifSuccess: [ :aResponse | aResponse model at: #blob ifAbsent: [ nil ] ]
		ifFailure: [ :aResponse | nil ]
		ifNone: [ nil ]
]

{ #category : #accessing }
LeClientApiCreateFile >> description [
	^ 'Create attachment content: ' , self snippetAttachment name
]

{ #category : #'api - actions' }
LeClientApiCreateFile >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	self
		assert: [ snippetAttachment isNotNil ]
		description: [ 'Snippet attachment is not defined' ].

	aResponse := self context client
			endpoint: LeClientEndpoints apiCreateFile;
			authenticated;
			entity: (ZnEntity bytes: snippetAttachment contents);
			onSuccessJsonModel;
			post.

	self addResponse: aResponse.
	^ aResponse
]

{ #category : #'api - actions' }
LeClientApiCreateFile >> prepare [
	"do nothing"
]

{ #category : #accessing }
LeClientApiCreateFile >> snippetAttachment [
	^ snippetAttachment
]

{ #category : #accessing }
LeClientApiCreateFile >> snippetAttachment: anObject [
	snippetAttachment := anObject
]
