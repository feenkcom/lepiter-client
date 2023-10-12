Class {
	#name : #LeClientSnippetAttachmentContents,
	#superclass : #Object,
	#traits : 'TLeClientContentsProvider',
	#classTraits : 'TLeClientContentsProvider classTrait',
	#instVars : [
		'snippetAttachment'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientSnippetAttachmentContents >> bytes [
	<return: #ByteArray>
	^ snippetAttachment contents
]

{ #category : #accessing }
LeClientSnippetAttachmentContents >> name [
	<return: #String>
	^ snippetAttachment name
]

{ #category : #accessing }
LeClientSnippetAttachmentContents >> snippetAttachment [
	<return: #LeSnippetAttachment>
	^ snippetAttachment
]

{ #category : #accessing }
LeClientSnippetAttachmentContents >> snippetAttachment: anObject [
	snippetAttachment := anObject
]
