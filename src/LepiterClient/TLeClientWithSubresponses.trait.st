Trait {
	#name : #TLeClientWithSubresponses,
	#instVars : [
		'subresponses'
	],
	#category : #'LepiterClient-Responses'
}

{ #category : #accessing }
TLeClientWithSubresponses >> subresponses [
	<return: #Collection of: #TLeClientResponse>
	^ subresponses ifNil: [ #() ]
]

{ #category : #accessing }
TLeClientWithSubresponses >> subresponses: aCollectionOfResponses [
	subresponses := aCollectionOfResponses
]
