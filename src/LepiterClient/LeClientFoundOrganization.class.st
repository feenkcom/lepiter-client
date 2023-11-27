Class {
	#name : #LeClientFoundOrganization,
	#superclass : #LeClientResponse,
	#instVars : [
		'subresponse',
		'databaseName',
		'database'
	],
	#category : #'LepiterClient-Responses'
}

{ #category : #accessing }
LeClientFoundOrganization >> database [
	<return: #LeClientOrganization>
	^ database
]

{ #category : #accessing }
LeClientFoundOrganization >> database: aLeClientDatabase [
	database := aLeClientDatabase
]

{ #category : #accessing }
LeClientFoundOrganization >> databaseId [
	<return: #String>
	^ self database ledatabase asString
]

{ #category : #accessing }
LeClientFoundOrganization >> databaseName [
	<return: #String>
	^ databaseName
]

{ #category : #accessing }
LeClientFoundOrganization >> databaseName: anObject [
	databaseName := anObject
]

{ #category : #accessing }
LeClientFoundOrganization >> description [
	^ 'found'
]

{ #category : #'gt - extensions' }
LeClientFoundOrganization >> gtDetails [
	^ super gtDetails , {
		{ 'database' . database }.
		{ 'database name' . databaseName }.
		{ 'database id' . self databaseId }
	}
]

{ #category : #testing }
LeClientFoundOrganization >> isSuccess [
	^ true
]

{ #category : #accessing }
LeClientFoundOrganization >> model [
	"Return a domain object or nil."

	^ self database
]

{ #category : #accessing }
LeClientFoundOrganization >> subresponse: anObject [
	subresponse := anObject
]

{ #category : #accessing }
LeClientFoundOrganization >> subresponses [
	"Return a collection of responses of commands that were execute as a part of this response."

	<return: #Collection of: #TLeClientResponse>
	^ LeClientUtility collectionWithoutNilItemFrom: subresponse
]
