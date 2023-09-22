Class {
	#name : #GtApLepiterRequestFailure,
	#superclass : #Object,
	#traits : 'TGtApLepiterResponse + TGtApLepiterZnClient',
	#classTraits : 'TGtApLepiterResponse classTrait + TGtApLepiterZnClient classTrait',
	#instVars : [
		'znClient'
	],
	#category : #'LepiterClient-Publishing'
}

{ #category : #'gt - extensions' }
GtApLepiterRequestFailure >> gtRequestJsonFor: aView [
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
GtApLepiterRequestFailure >> gtResponseJsonFor: aView [
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
GtApLepiterRequestFailure >> printOn: stream [
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
GtApLepiterRequestFailure >> znClient [
	^ znClient
]

{ #category : #accessing }
GtApLepiterRequestFailure >> znClient: anObject [
	znClient := anObject
]
