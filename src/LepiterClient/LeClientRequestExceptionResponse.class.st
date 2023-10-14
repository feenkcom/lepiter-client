Class {
	#name : #LeClientRequestExceptionResponse,
	#superclass : #Object,
	#traits : 'TLeClientResponse + TLeClientExceptionViews',
	#classTraits : 'TLeClientResponse classTrait + TLeClientExceptionViews classTrait',
	#instVars : [
		'exception',
		'request',
		'subresponses'
	],
	#category : #'LepiterClient-Responses'
}

{ #category : #accessing }
LeClientRequestExceptionResponse >> description [
	^ 'exception'
]

{ #category : #accessing }
LeClientRequestExceptionResponse >> exception [
	<return: #Exception>
	^ exception
]

{ #category : #accessing }
LeClientRequestExceptionResponse >> exception: anException [
	exception := anException
]

{ #category : #'api - convenience' }
LeClientRequestExceptionResponse >> freeze: anException [
	| anExceptionCopy |
	anExceptionCopy := anException copy.

	anExceptionCopy signalContext ifNotNil: [ anExceptionCopy freeze ].
	self exception: anExceptionCopy
]

{ #category : #'gt - extensions' }
LeClientRequestExceptionResponse >> gtExceptionMessageTextFor: aView [
	<gtView>
	self exception ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Exception message';
		priority: 15;
		object: [ self exception ];
		view: #gtMessageTextFor:
]

{ #category : #'gt - extensions' }
LeClientRequestExceptionResponse >> gtRequestJsonFor: aView [
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

{ #category : #testing }
LeClientRequestExceptionResponse >> hasResponse [
	<return: #Boolean>
	^ false
]

{ #category : #testing }
LeClientRequestExceptionResponse >> isException [
	^ true
]

{ #category : #accessing }
LeClientRequestExceptionResponse >> model [
	"Return a domain object or nil."

	^ nil
]

{ #category : #accessing }
LeClientRequestExceptionResponse >> request [
	<return: #ZnRequest>
	^ request
]

{ #category : #accessing }
LeClientRequestExceptionResponse >> request: aRequest [
	request := aRequest
]

{ #category : #accessing }
LeClientRequestExceptionResponse >> subresponses [
	"Return a collection of responses of commands that were execute as a part of this response."

	<return: #Collection of: #TLeClientResponse>
	^ subresponses ifNil: [ #() ]
]

{ #category : #accessing }
LeClientRequestExceptionResponse >> subresponses: anObject [
	subresponses := anObject
]
