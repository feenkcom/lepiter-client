Class {
	#name : #LeClientUtility,
	#superclass : #Object,
	#category : #'LepiterClient-Utilities'
}

{ #category : #utilities }
LeClientUtility class >> assertDatabaseId: aDatabaseId [
	self
		assert: [ aDatabaseId isNotNil ]
		description: [ 'Database UUID must be non-nil' ].

	self
		assert: [ aDatabaseId isString ]
		description: [ 'Database UUID must be a string: {1}' format: {aDatabaseId} ].
	self
		assert: [ self validateUUID: aDatabaseId ]
		description: [ 'Database UUID must be of the following format xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx: {1}'
				format: {aDatabaseId} ]
]

{ #category : #utilities }
LeClientUtility class >> collectionWithoutNilItemFrom: anItemOrNil [
	^ anItemOrNil ifNotNil: [ :anItem | {anItem} ] ifNil: [ #() ]
]

{ #category : #utilities }
LeClientUtility class >> collectionWithoutNilItemsFrom: aCollection [
	aCollection ifNil: [ ^ #() ].
	^ Array
		new: (aCollection count: #isNotNil)
		streamContents: [ :aStream | 
			aCollection do: [ :anItemOrNil | 
				anItemOrNil ifNotNil: [ aStream nextPut: anItemOrNil ] ] ]
]

{ #category : #utilities }
LeClientUtility class >> validateUUID: aString [
	<return: #Boolean>
	^ '^[0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12}$' asRegex
		matches: aString
]
