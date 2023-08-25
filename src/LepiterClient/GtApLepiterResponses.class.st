Class {
	#name : #GtApLepiterResponses,
	#superclass : #Object,
	#traits : 'TGtApLepiterResponse',
	#classTraits : 'TGtApLepiterResponse classTrait',
	#instVars : [
		'responses'
	],
	#category : #'LepiterClient-Publishing'
}

{ #category : #'gt - extensions' }
GtApLepiterResponses >> gtResponsesFor: aView [
	<gtView>
	responses ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Responses';
		items: [ self responses ifNil: [ #() ] ];
		column: 'Index'
			text: [ :_ :i | i ]
			width: 40;
		column: 'Method'
			text: [ :response | response method ]
			width: 60;
		column: 'URI'
			text: [ :response | response uriPathQueryFragment ];
		column: 'Code'
			text: [ :response | response code ];
		column: 'Reason'
			text: [ :response | response reason ]
]

{ #category : #testing }
GtApLepiterResponses >> isSuccess [
	^ self responses allSatisfy: #isSuccess
]

{ #category : #accessing }
GtApLepiterResponses >> responses [
	^ responses
]

{ #category : #accessing }
GtApLepiterResponses >> responses: anObject [
	responses := anObject
]
