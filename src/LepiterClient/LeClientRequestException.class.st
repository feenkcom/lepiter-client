Class {
	#name : #LeClientRequestException,
	#superclass : #Object,
	#traits : 'TLeClientResponse',
	#classTraits : 'TLeClientResponse classTrait',
	#instVars : [
		'exception',
		'request',
		'subresponses'
	],
	#category : #'LepiterClient-Responses'
}

{ #category : #accessing }
LeClientRequestException >> description [
	^ 'exception'
]

{ #category : #accessing }
LeClientRequestException >> exception [
	<return: #Exception>
	^ exception
]

{ #category : #accessing }
LeClientRequestException >> exception: anException [
	exception := anException
]

{ #category : #'api - convenience' }
LeClientRequestException >> freeze: anException [
	| anExceptionCopy |
	anExceptionCopy := anException copy.

	anExceptionCopy signalContext ifNotNil: [ anExceptionCopy freeze ].
	self exception: anExceptionCopy
]

{ #category : #'gt - extensions' }
LeClientRequestException >> gtRequestJsonFor: aView [
	<gtView>
	self request entity ifNil: [ ^ aView empty ].
	self request contentType ifNil: [ ^ aView empty ].
	self request contentType main = 'application' ifFalse: [ ^ aView empty ].
	self request contentType sub = 'json' ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'Request';
		priority: 70;
		object: [ self request ];
		view: #gtJsonFor:
]

{ #category : #accessing }
LeClientRequestException >> model [
	"Return a domain object or nil."

	^ nil
]

{ #category : #accessing }
LeClientRequestException >> request [
	<return: #ZnRequest>
	^ request
]

{ #category : #accessing }
LeClientRequestException >> request: aRequest [
	request := aRequest
]

{ #category : #accessing }
LeClientRequestException >> subresponses [
	"Return a collection of responses of commands that were execute as a part of this response."

	<return: #Collection of: #TLeClientResponse>
	^ subresponses
]

{ #category : #accessing }
LeClientRequestException >> subresponses: anObject [
	subresponses := anObject
]
