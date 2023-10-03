Class {
	#name : #LeClientModelExistResponse,
	#superclass : #Object,
	#traits : 'TLeClientResponse - {#description} + TLeClientZincResponse',
	#classTraits : 'TLeClientResponse classTrait + TLeClientZincResponse classTrait',
	#instVars : [
		'subresponse'
	],
	#category : #'LepiterClient-Responses'
}

{ #category : #accessing }
LeClientModelExistResponse >> color [
	^ self
		ifExist: [ BrGlamorousColors successBackgroundColor ]
		ifMissing: [ BrGlamorousColors failureBackgroundColor ]
		ifFailure: [ BrGlamorousColors errorBackgroundColor ]
		ifNone: [ BrGlamorousColors disabledButtonTextColor ]
]

{ #category : #testing }
LeClientModelExistResponse >> ifExist: existBlock ifMissing: missingBlock ifFailure: failureBlock ifNone: noneBlock [
	^ self subresponse
		ifSuccess: [ existBlock cull: self ]
		ifFailure: [ self isNotFound
				ifTrue: [ missingBlock cull: self ]
				ifFalse: [ failureBlock cull: self ] ]
		ifNone: noneBlock
]

{ #category : #testing }
LeClientModelExistResponse >> isSuccess [
	^ self response isSuccess
]

{ #category : #accessing }
LeClientModelExistResponse >> request [
	<return: #ZnRequest>
	^ self subresponse request
]

{ #category : #accessing }
LeClientModelExistResponse >> response [
	<return: #ZnResponse>
	^ self subresponse response
]

{ #category : #accessing }
LeClientModelExistResponse >> subresponse [
	<return: #TLeClientResponse>
	^ subresponse
]

{ #category : #accessing }
LeClientModelExistResponse >> subresponse: aResponse [
	subresponse := aResponse
]

{ #category : #accessing }
LeClientModelExistResponse >> subresponses [
	"Return a collection of responses of commands that were execute as a part of this response."

	<return: #Collection of: #TLeClientResponse>
	^ {subresponse}
]
