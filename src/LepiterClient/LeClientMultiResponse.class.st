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
			self subresponses size isZero
				ifTrue: [ aStream nextPutAll: 'missing responses' ].
			aSuccessCount isZero
				ifFalse: [ aStream print: aSuccessCount.
					aStream nextPutAll: ' success'.
					aSuccessCount = 1 ifFalse: [ aStream nextPutAll: 'es' ] ].
			aFailureCount isZero
				ifFalse: [ aSuccessCount isZero ifFalse: [ aStream space ].
					aStream print: aFailureCount.
					aStream nextPutAll: (' failure' asPluralBasedOn: aFailureCount) ] ]
]

{ #category : #testing }
LeClientMultiResponse >> ifSuccess: successBlock ifFailure: failureBlock ifNone: noneBlock [
	^ self subresponses
		ifEmpty: noneBlock
		ifNotEmpty: [ self isSuccess
				ifTrue: [ successBlock cull: self ]
				ifFalse: [ failureBlock cull: self ] ]
]

{ #category : #testing }
LeClientMultiResponse >> isSuccess [
	^ self subresponses isNotEmpty
		and: [ self subresponses allSatisfy: #isSuccess ]
]

{ #category : #accessing }
LeClientMultiResponse >> model [
	"Return a domain object or nil."

	^ self
		ifSuccess: [ self subresponses last model ]
		ifFailure: [ nil ]
		ifNone: [ nil ]
]

{ #category : #accessing }
LeClientMultiResponse >> subresponses [
	"Return a collection of responses of commands that were execute as a part of this response."

	<return: #Collection of: #TLeClientResponse>
	^ subresponses ifNil: [ #() ]
]

{ #category : #accessing }
LeClientMultiResponse >> subresponses: aCollection [
	subresponses := LeClientUtility collectionWithoutNilItemsFrom: aCollection
]
