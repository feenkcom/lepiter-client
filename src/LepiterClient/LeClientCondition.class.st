Class {
	#name : #LeClientCondition,
	#superclass : #LeClientCommand,
	#instVars : [
		'check',
		'onSuccess',
		'onNotFound',
		'description'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientCondition >> check [
	<return: #TLeClientCommand>
	^ check
]

{ #category : #accessing }
LeClientCondition >> check: aCommand [
	check := aCommand
]

{ #category : #accessing }
LeClientCondition >> commands [
	^ LeClientCommandUtility collectionForCommands: { check. onSuccess. onNotFound }
]

{ #category : #accessing }
LeClientCondition >> description [
	^ description ifNil: [ super description ]
]

{ #category : #accessing }
LeClientCondition >> description: aString [
	description := aString
]

{ #category : #'api - actions' }
LeClientCondition >> execute [
	<return: #TLeClientResponse>
	| checkResponse successResponse notFoundResponse aResponse |
	checkResponse := self check execute.

	checkResponse
		ifExist: [ successResponse := onSuccess execute ]
		ifMissing: [ notFoundResponse := onNotFound execute ]
		ifFailure: [  "may happen" ]
		ifNone: [  "must not happen" ].


	aResponse := LeClientConditionResponse
			check: checkResponse
			other: {successResponse.
					notFoundResponse}.
	self addResponse: aResponse.
	^ aResponse
]

{ #category : #accessing }
LeClientCondition >> onNotFound [
	<return: #TLeClientCommand>
	^ onNotFound
]

{ #category : #accessing }
LeClientCondition >> onNotFound: aCommand [
	onNotFound := aCommand
]

{ #category : #accessing }
LeClientCondition >> onSuccess [
	<return: #TLeClientCommand>
	^ onSuccess
]

{ #category : #accessing }
LeClientCondition >> onSuccess: aCommand [
	onSuccess := aCommand
]

{ #category : #'api - actions' }
LeClientCondition >> prepare [
	self check prepare.
	self onSuccess prepare.
	self onNotFound prepare
]
