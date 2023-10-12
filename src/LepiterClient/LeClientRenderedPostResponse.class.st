Class {
	#name : #LeClientRenderedPostResponse,
	#superclass : #Object,
	#traits : 'TLeClientResponse',
	#classTraits : 'TLeClientResponse classTrait',
	#instVars : [
		'exportResponse',
		'resourcesResponse',
		'createRenderedPostResponse'
	],
	#category : #'LepiterClient-Responses'
}

{ #category : #accessing }
LeClientRenderedPostResponse >> createRenderedPostResponse [
	^ createRenderedPostResponse
]

{ #category : #accessing }
LeClientRenderedPostResponse >> createRenderedPostResponse: anObject [
	createRenderedPostResponse := anObject
]

{ #category : #accessing }
LeClientRenderedPostResponse >> description [
	^ self
		ifSuccess: [ 'rendered' ]
		ifFailure: [ | someErrors |
			someErrors := self subresponses select: [ :each | each isSuccess not ].
			someErrors last description ]
		ifNone: [ 'skipped' ]
]

{ #category : #accessing }
LeClientRenderedPostResponse >> exportResponse [
	^ exportResponse
]

{ #category : #accessing }
LeClientRenderedPostResponse >> exportResponse: anObject [
	exportResponse := anObject
]

{ #category : #accessing }
LeClientRenderedPostResponse >> filePath [
	<return: #RelativePath>
	^ self
		ifSuccess: [ Path * createRenderedPostResponse model filePath ]
		ifFailure: [ nil ]
		ifNone: [ nil ]
]

{ #category : #testing }
LeClientRenderedPostResponse >> isSuccess [
	^ self subresponses
		ifEmpty: [ false ]
		ifNotEmpty: [ :aCollection | aCollection allSatisfy: #isSuccess ]
]

{ #category : #accessing }
LeClientRenderedPostResponse >> model [
	"Return a domain object or nil."

	<return: #LeClientPost>
	^ self
		ifSuccess: [ createRenderedPostResponse model ]
		ifFailure: [ nil ]
		ifNone: [ nil ]
]

{ #category : #accessing }
LeClientRenderedPostResponse >> post [
	<return: #LeClientPost>
	^ self
		ifSuccess: [ createRenderedPostResponse model post ]
		ifFailure: [ nil ]
		ifNone: [ nil ]
]

{ #category : #accessing }
LeClientRenderedPostResponse >> resourcesResponse [
	^ resourcesResponse
]

{ #category : #accessing }
LeClientRenderedPostResponse >> resourcesResponse: anObject [
	resourcesResponse := anObject
]

{ #category : #accessing }
LeClientRenderedPostResponse >> serverPost [
	<return: #LeClientPost>
	^ self
		ifSuccess: [ createRenderedPostResponse model ]
		ifFailure: [ nil ]
		ifNone: [ nil ]
]

{ #category : #accessing }
LeClientRenderedPostResponse >> subresponses [
	"Return a collection of responses of commands that were execute as a part of this response."

	<return: #Collection of: #TLeClientResponse>
	^ LeClientUtility
		collectionWithoutNilItemsFrom: {exportResponse.
				resourcesResponse.
				createRenderedPostResponse}
]
