Class {
	#name : #LeClientCreateAttachment,
	#superclass : #LeClientCommand,
	#traits : 'TLeClientWithCommands',
	#classTraits : 'TLeClientWithCommands classTrait',
	#instVars : [
		'snippetAttachment',
		'serverDatabaseId'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientCreateAttachment >> description [
	^ 'Publish attachment: ' , self snippetAttachment name
]

{ #category : #'api - actions' }
LeClientCreateAttachment >> prepare [
	| aCreateFile |
	self commands size > 1 ifTrue: [  "Commands were already created"^ self ].

	aCreateFile := LeClientCreateFile new
			context: context;
			snippetAttachment: snippetAttachment.

	self addCommand: aCreateFile.

	aCreateFile prepare
]

{ #category : #accessing }
LeClientCreateAttachment >> serverDatabaseId [
	^ serverDatabaseId
]

{ #category : #accessing }
LeClientCreateAttachment >> serverDatabaseId: anObject [
	serverDatabaseId := anObject
]

{ #category : #accessing }
LeClientCreateAttachment >> snippetAttachment [
	^ snippetAttachment
]

{ #category : #accessing }
LeClientCreateAttachment >> snippetAttachment: anObject [
	snippetAttachment := anObject
]
