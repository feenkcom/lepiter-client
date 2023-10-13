Class {
	#name : #LeClientRequestFailure,
	#superclass : #Object,
	#traits : 'TLeClientResponse - {#description. #subresponses} + TLeClientZincResponse + TLeClientWithSubresponses',
	#classTraits : 'TLeClientResponse classTrait + TLeClientZincResponse classTrait + TLeClientWithSubresponses classTrait',
	#instVars : [
		'request',
		'response'
	],
	#category : #'LepiterClient-Responses'
}

{ #category : #'gt - extensions' }
LeClientRequestFailure >> gtResponseJsonFor: aView [
	<gtView>
	self isNoContent ifTrue: [ ^ aView empty ].
	self contentType main = 'application' ifFalse: [ ^ aView empty ].
	self contentType sub = 'json' ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'Response';
		priority: 10;
		object: [ self response ];
		view: #gtJsonFor:
]

{ #category : #accessing }
LeClientRequestFailure >> model [
	"Return a domain object or nil."

	^ nil
]

{ #category : #printing }
LeClientRequestFailure >> printOn: stream [
	super printOn: stream.
	stream nextPut: $(.
	"Request"
	self requestLine printMethodAndUriOn: stream.
	
	stream nextPutAll: ': '.
	
	"Response"
	self statusLine printCodeAndReasonOn: stream.
	self hasEntity ifTrue: [
		stream space.
		self entity printContentTypeAndLengthOn: stream.
		
		stream cr.
		stream print: self entity contents ].
	
	stream nextPut: $)
]

{ #category : #accessing }
LeClientRequestFailure >> request [
	<return: #ZnRequest>
	^ request
]

{ #category : #accessing }
LeClientRequestFailure >> request: anObject [
	request := anObject
]

{ #category : #accessing }
LeClientRequestFailure >> response [
	<return: #ZnResponse>
	^ response
]

{ #category : #accessing }
LeClientRequestFailure >> response: anObject [
	response := anObject
]
