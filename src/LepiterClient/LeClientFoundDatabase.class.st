Class {
	#name : #LeClientFoundDatabase,
	#superclass : #Object,
	#traits : 'TLeClientResponse',
	#classTraits : 'TLeClientResponse classTrait',
	#instVars : [
		'subresponse',
		'databaseName',
		'database'
	],
	#category : #'LepiterClient-Responses'
}

{ #category : #accessing }
LeClientFoundDatabase >> database [
	^ database
]

{ #category : #accessing }
LeClientFoundDatabase >> database: anObject [
	database := anObject
]

{ #category : #accessing }
LeClientFoundDatabase >> databaseId [
	<return: #String>
	^ self database uuid asString
]

{ #category : #accessing }
LeClientFoundDatabase >> databaseName [
	^ databaseName
]

{ #category : #accessing }
LeClientFoundDatabase >> databaseName: anObject [
	databaseName := anObject
]

{ #category : #accessing }
LeClientFoundDatabase >> description [
	^ 'found'
]

{ #category : #testing }
LeClientFoundDatabase >> isSuccess [
	^ true
]

{ #category : #accessing }
LeClientFoundDatabase >> subresponse: anObject [
	subresponse := anObject
]

{ #category : #accessing }
LeClientFoundDatabase >> subresponses [
	"Return a collection of responses of commands that were execute as a part of this response."

	<return: #Collection of: #TLeClientResponse>
	^ LeClientUtility collectionWithoutNilItemFrom: subresponse
]
