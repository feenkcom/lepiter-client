Class {
	#name : #LeClientModelExistResponse,
	#superclass : #LeClientResponse,
	#traits : 'TLeClientZincResponse',
	#classTraits : 'TLeClientZincResponse classTrait',
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
		ifException: [ BrGlamorousColors errorBackgroundColor ]
		ifNone: [ BrGlamorousColors disabledButtonTextColor ]
]

{ #category : #accessing }
LeClientModelExistResponse >> description [
	^ self subresponse ifNotNil: #description ifNil: [ '<undefined>' ]
]

{ #category : #'gt - extensions' }
LeClientModelExistResponse >> hasResponse [
	<return: #Boolean>
	^ self subresponse ifNotNil: #hasResponse ifNil: [ false ]
]

{ #category : #testing }
LeClientModelExistResponse >> ifExist: existBlock ifMissing: missingBlock ifFailure: failureBlock ifException: exceptionBlock ifNone: noneBlock [
	^ self subresponse
		ifSuccess: [ existBlock cull: self ]
		ifFailure: [ 
			self isException
				ifFalse: [ self isNotFound
						ifTrue: [ missingBlock cull: self ]
						ifFalse: [ failureBlock cull: self ] ]
				ifTrue: [ exceptionBlock cull: self ] ]
		ifNone: noneBlock
]

{ #category : #testing }
LeClientModelExistResponse >> isException [
	^ self subresponse isException
]

{ #category : #testing }
LeClientModelExistResponse >> isSuccess [
	^ self subresponse isSuccess
]

{ #category : #accessing }
LeClientModelExistResponse >> model [
	^ self subresponse model
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
	^ LeClientUtility collectionWithoutNilItemFrom: subresponse
]
