Class {
	#name : #LeClientRequestFailure,
	#superclass : #Object,
	#traits : 'TGtApLepiterResponse + TGtApLepiterZnClient',
	#classTraits : 'TGtApLepiterResponse classTrait + TGtApLepiterZnClient classTrait',
	#instVars : [
		'znClient'
	],
	#category : #'LepiterClient-Publishing'
}

{ #category : #'gt - extensions' }
LeClientRequestFailure >> gtRequestJsonFor: aView [
	<gtView>
	self isNoContent ifTrue: [ ^ aView empty ].
	self contentType main = 'application' ifFalse: [ ^ aView empty ].
	self contentType sub = 'json' ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'Request';
		priority: 5;
		object: [ self request ];
		view: #gtJsonFor:
]

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
LeClientRequestFailure >> znClient [
	^ znClient
]

{ #category : #accessing }
LeClientRequestFailure >> znClient: anObject [
	znClient := anObject
]
