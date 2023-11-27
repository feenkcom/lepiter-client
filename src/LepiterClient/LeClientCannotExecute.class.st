Class {
	#name : #LeClientCannotExecute,
	#superclass : #LeClientResponse,
	#instVars : [
		'subresponses'
	],
	#category : #'LepiterClient-Responses'
}

{ #category : #accessing }
LeClientCannotExecute >> description [
	^ 'cannot execute'
]

{ #category : #accessing }
LeClientCannotExecute >> model [
	"Return a domain object or nil."

	^ nil
]

{ #category : #accessing }
LeClientCannotExecute >> subresponse: aResponse [
	subresponses := LeClientUtility collectionWithoutNilItemFrom: aResponse
]

{ #category : #accessing }
LeClientCannotExecute >> subresponses [
	"Return a collection of responses of commands that were execute as a part of this response."

	<return: #Collection of: #TLeClientResponse>
	^ subresponses ifNil: [ #() ]
]

{ #category : #accessing }
LeClientCannotExecute >> subresponses: aCollection [
	subresponses := LeClientUtility collectionWithoutNilItemsFrom: aCollection
]
