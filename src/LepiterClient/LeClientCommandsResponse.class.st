Class {
	#name : #LeClientCommandsResponse,
	#superclass : #Object,
	#traits : 'TLeClientResponse',
	#classTraits : 'TLeClientResponse classTrait',
	#instVars : [
		'responses'
	],
	#category : #'LepiterClient-Responses'
}

{ #category : #'instance creation' }
LeClientCommandsResponse class >> fromCommand: aParentCommand [
	| allResponses |
	allResponses := aParentCommand commands
			collect: [ :aCommand | aCommand lastResponse ifNil: [ LeClientNoResponse new ] ].
	^ self new responses: allResponses
]

{ #category : #accessing }
LeClientCommandsResponse >> description [
	^ String
		streamContents: [ :aStream | 
			| aSuccessCount aFailureCount |
			aSuccessCount := self responses count: #isSuccess.
			aFailureCount := self responses size - aSuccessCount.
			aSuccessCount isZero
				ifFalse: [ aStream print: aSuccessCount.
					aStream nextPutAll: (' success' asPluralBasedOn: aSuccessCount) ].
			aFailureCount isZero
				ifFalse: [ aStream print: aFailureCount.
					aStream nextPutAll: (' failure' asPluralBasedOn: aFailureCount) ] ]
]

{ #category : #testing }
LeClientCommandsResponse >> isSuccess [
	^ self responses allSatisfy: #isSuccess
]

{ #category : #accessing }
LeClientCommandsResponse >> responses [
	<return: #Collection of: #TLeClientResponse>
	^ responses
]

{ #category : #accessing }
LeClientCommandsResponse >> responses: aCollection [
	responses := aCollection
]
