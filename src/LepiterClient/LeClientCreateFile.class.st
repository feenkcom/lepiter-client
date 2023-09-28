Class {
	#name : #LeClientCreateFile,
	#superclass : #LeClientCommand,
	#instVars : [
		'snippetAttachment'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientCreateFile >> description [
	^ 'Publish attachment content: ' , self snippetAttachment name
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
