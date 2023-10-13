Class {
	#name : #LeClientNoneOrganization,
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
LeClientNoneOrganization >> databaseName [
	^ databaseName
]

{ #category : #accessing }
LeClientNoneOrganization >> databaseName: anObject [
	databaseName := anObject
]

{ #category : #accessing }
LeClientNoneOrganization >> description [
	^ 'not found'
]

{ #category : #accessing }
LeClientNoneOrganization >> model [
	"Return a domain object or nil."

	^ nil
]

{ #category : #accessing }
LeClientNoneOrganization >> subresponse: anObject [
	subresponse := anObject
]

{ #category : #accessing }
LeClientNoneOrganization >> subresponses [
	"Return a collection of responses of commands that were execute as a part of this response."

	<return: #Collection of: #TLeClientResponse>
	^ LeClientUtility collectionWithoutNilItemFrom: subresponse
]
