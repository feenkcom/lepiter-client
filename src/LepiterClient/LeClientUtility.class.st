Class {
	#name : #LeClientUtility,
	#superclass : #Object,
	#category : #'LepiterClient-Utilities'
}

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
