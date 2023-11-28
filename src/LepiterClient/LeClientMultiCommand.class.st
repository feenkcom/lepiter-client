Class {
	#name : #LeClientMultiCommand,
	#superclass : #LeClientCompositeCommand,
	#instVars : [
		'commands',
		'name'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientMultiCommand >> commands [
	^ commands ifNil: [ #() ]
]

{ #category : #accessing }
LeClientMultiCommand >> commands: aCollection [
	commands := LeClientUtility collectionWithoutNilItemsFrom: aCollection
]

{ #category : #accessing }
LeClientMultiCommand >> description [
	^ String
		streamContents: [ :aStream | 
			self name
				ifNotNil: [ :aName | 
					aStream
						nextPutAll: aName asString;
						nextPutAll: ': ' ].
			aStream
				print: self commands size;
				space.
			aStream nextPutAll: ('action' asPluralBasedOn: self commands size) ]
]

{ #category : #'api - actions' }
LeClientMultiCommand >> execute [
	<return: #TLeClientResponse>
	| allResponses aResponse |
	self
		ifSuccess: [ :aPreviousResponse | ^ aPreviousResponse ]
		ifFailure: [  "repeat" ]
		ifNone: [  "execute" ].

	allResponses := commands collect: #execute.
	aResponse := LeClientMultiResponse new subresponses: allResponses.
	self addResponse: aResponse.
	^ aResponse
]

{ #category : #'gt - extensions' }
LeClientMultiCommand >> gtDetails [
	^ super gtDetails , {
		{ 'name' . name ifNil: [ '' ] . name }.
		{ 'commands' . commands size. commands }
	}
]

{ #category : #accessing }
LeClientMultiCommand >> name [
	^ name
]

{ #category : #accessing }
LeClientMultiCommand >> name: anObject [
	name := anObject
]

{ #category : #'api - actions' }
LeClientMultiCommand >> prepare [
	commands do: #prepare
]
