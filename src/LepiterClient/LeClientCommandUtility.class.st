Class {
	#name : #LeClientCommandUtility,
	#superclass : #Object,
	#category : #'LepiterClient-Utilities'
}

{ #category : #utilities }
LeClientCommandUtility class >> addCommand: aCommand subresponsesToResponse: aResponse [
	| allResponses |
	allResponses := aCommand commands collect: #lastResponse.
	aResponse subresponses: allResponses
]

{ #category : #utilities }
LeClientCommandUtility class >> collectionForCommand: aCommandOrNil [
	^ aCommandOrNil ifNotNil: [ :aCommand | {aCommand} ] ifNil: [ #() ]
]

{ #category : #utilities }
LeClientCommandUtility class >> collectionForCommands: aCollection [
	^ Array
		new: (aCollection count: #isNotNil)
		streamContents: [ :aStream | 
			aCollection do: [ :aCommand | 
				aCommand ifNotNil: [ aStream nextPut: aCommand ] ] ]
]
