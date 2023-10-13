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
	<return: #LeClientDatabase>
	^ database
]

{ #category : #accessing }
LeClientFoundDatabase >> database: aLeClientDatabase [
	database := aLeClientDatabase
]

{ #category : #accessing }
LeClientFoundDatabase >> databaseId [
	<return: #String>
	^ self database ledatabase asString
]

{ #category : #accessing }
LeClientFoundDatabase >> databaseName [
	<return: #String>
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
LeClientFoundDatabase >> model [
	"Return a domain object or nil."

	^ self database
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
