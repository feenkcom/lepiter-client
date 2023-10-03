Class {
	#name : #LeClientMultiResponse,
	#superclass : #Object,
	#traits : 'TLeClientResponse',
	#classTraits : 'TLeClientResponse classTrait',
	#instVars : [
		'subresponses'
	],
	#category : #'LepiterClient-Responses'
}

{ #category : #'instance creation' }
LeClientMultiResponse class >> fromCommand: aParentCommand [
	| allResponses |
	allResponses := aParentCommand commands
			collect: [ :aCommand | aCommand lastResponse ].
	^ self new subresponses: allResponses
]

{ #category : #accessing }
LeClientMultiResponse >> description [
	^ String
		streamContents: [ :aStream | 
			| aSuccessCount aFailureCount |
			aSuccessCount := self subresponses count: #isSuccess.
			aFailureCount := self subresponses size - aSuccessCount.
			aSuccessCount isZero
				ifFalse: [ aStream print: aSuccessCount.
					aStream nextPutAll: (' success' asPluralBasedOn: aSuccessCount) ].
			aFailureCount isZero
				ifFalse: [ aStream print: aFailureCount.
					aStream nextPutAll: (' failure' asPluralBasedOn: aFailureCount) ] ]
]

{ #category : #testing }
LeClientMultiResponse >> isSuccess [
	^ self subresponses allSatisfy: #isSuccess
]

{ #category : #accessing }
LeClientMultiResponse >> subresponses [
	"Return a collection of responses of commands that were execute as a part of this response."

	<return: #Collection of: #TLeClientResponse>
	^ subresponses 
]

{ #category : #accessing }
LeClientMultiResponse >> subresponses: aCollection [
	subresponses := aCollection
]
