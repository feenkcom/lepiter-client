Class {
	#name : #LeClientNoneDatabase,
	#superclass : #Object,
	#traits : 'TLeClientResponse',
	#classTraits : 'TLeClientResponse classTrait',
	#instVars : [
		'databaseName',
		'subresponse'
	],
	#category : #'LepiterClient-Responses'
}

{ #category : #accessing }
LeClientNoneDatabase >> databaseName [
	^ databaseName
]

{ #category : #accessing }
LeClientNoneDatabase >> databaseName: anObject [
	databaseName := anObject
]

{ #category : #accessing }
LeClientNoneDatabase >> description [
	^ 'not found'
]

{ #category : #accessing }
LeClientNoneDatabase >> subresponse: anObject [
	subresponse := anObject
]

{ #category : #accessing }
LeClientNoneDatabase >> subresponses [
	"Return a collection of responses of commands that were execute as a part of this response."

	<return: #Collection of: #TLeClientResponse>
	^ LeClientUtility collectionWithoutNilItemFrom: subresponse
]
