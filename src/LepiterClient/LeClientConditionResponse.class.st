Class {
	#name : #LeClientConditionResponse,
	#superclass : #Object,
	#traits : 'TLeClientResponse',
	#classTraits : 'TLeClientResponse classTrait',
	#instVars : [
		'check',
		'subsequent'
	],
	#category : #'LepiterClient-Responses'
}

{ #category : #'instance creation' }
LeClientConditionResponse class >> check: checkResponse other: otherResponses [
	| subsequent |
	self
		assert: [ (otherResponses count: #isNotNil) < 2 ]
		description: [ 'There must be exactly one or zero non-nil objects: {1}' format: {otherResponses} ].

	subsequent := otherResponses detect: #isNotNil ifNone: [ nil ].
	^ self new
		check: checkResponse;
		subsequent: subsequent
]

{ #category : #accessing }
LeClientConditionResponse >> check [
	<return: #TLeClientResponse>
	^ check
]

{ #category : #accessing }
LeClientConditionResponse >> check: aResponse [
	check := aResponse
]

{ #category : #accessing }
LeClientConditionResponse >> color [
	^ self check
		ifExist: [ self subsequent color ]
		ifMissing: [ self subsequent color ]
		ifFailure: [ BrGlamorousColors errorBackgroundColor ]
		ifNone: [ LeClientNoResponse defaultColor ]
]

{ #category : #accessing }
LeClientConditionResponse >> description [
	^ self check
		ifExist: [ self subsequent description ]
		ifMissing: [ self subsequent description ]
		ifFailure: [ self check description ]
		ifNone: [ LeClientNoResponse defaultDescription ]
]

{ #category : #testing }
LeClientConditionResponse >> ifSuccess: successBlock ifFailure: failureBlock ifNone: noneBlock [
	^ self relevant
		ifSuccess: successBlock
		ifFailure: failureBlock
		ifNone: noneBlock
]

{ #category : #testing }
LeClientConditionResponse >> isSuccess [
	^ self relevant isSuccess
]

{ #category : #accessing }
LeClientConditionResponse >> model [
	"Return a domain object or nil."

	^ self
		ifSuccess: #model
		ifFailure: [ nil ]
		ifNone: [ nil ]
]

{ #category : #accessing }
LeClientConditionResponse >> relevant [
	<return: #TLeClientResponse>
	^ self subsequent ifNil: [ self check ]
]

{ #category : #accessing }
LeClientConditionResponse >> subresponses [
	"Return a collection of responses of commands that were execute as a part of this response."

	<return: #Collection of: #TLeClientResponse>
	^ LeClientUtility collectionWithoutNilItemsFrom: {check. subsequent}
]

{ #category : #accessing }
LeClientConditionResponse >> subsequent [
	<return: #TLeClientResponse or: nil>
	^ subsequent
]

{ #category : #accessing }
LeClientConditionResponse >> subsequent: aResponse [
	subsequent := aResponse
]
