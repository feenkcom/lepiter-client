Class {
	#name : #LeClientCreateFile,
	#superclass : #LeClientCommand,
	#instVars : [
		'snippetAttachment'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientCreateFile >> blob [
	<return: #String or: nil>
	^ self
		ifSuccessDo: [ :aResponse | aResponse model at: #blob ifAbsent: [ nil ] ]
		ifFailureDo: [ :aResponse | nil ]
		ifNone: [ nil ]
]

{ #category : #accessing }
LeClientCreateFile >> description [
	^ 'Publish attachment content: ' , self snippetAttachment name
]

{ #category : #'api - actions' }
LeClientCreateFile >> execute [
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
LeClientCreateFile >> prepare [
	"do nothing"
]

{ #category : #accessing }
LeClientCreateFile >> snippetAttachment [
	^ snippetAttachment
]

{ #category : #accessing }
LeClientCreateFile >> snippetAttachment: anObject [
	snippetAttachment := anObject
]
