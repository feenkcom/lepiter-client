Class {
	#name : #LeClientExceptionResponse,
	#superclass : #Object,
	#traits : 'TLeClientResponse',
	#classTraits : 'TLeClientResponse classTrait',
	#instVars : [
		'exception',
		'subresponses'
	],
	#category : #'LepiterClient-Responses'
}

{ #category : #accessing }
LeClientExceptionResponse >> description [
	^ 'exception'
]

{ #category : #accessing }
LeClientExceptionResponse >> exception [
	<return: #Exception>
	^ exception
]

{ #category : #accessing }
LeClientExceptionResponse >> exception: anException [
	exception := anException
]

{ #category : #'api - convenience' }
LeClientExceptionResponse >> freeze: anException [
	| anExceptionCopy |
	anExceptionCopy := anException copy.

	anExceptionCopy signalContext ifNotNil: [ anExceptionCopy freeze ].
	self exception: anExceptionCopy
]

{ #category : #accessing }
LeClientExceptionResponse >> model [
	"Return a domain object or nil."

	^ nil
]

{ #category : #accessing }
LeClientExceptionResponse >> subresponses [
	"Return a collection of responses of commands that were execute as a part of this response."

	<return: #Collection of: #TLeClientResponse>
	^ subresponses ifNil: [ #() ]
]

{ #category : #accessing }
LeClientExceptionResponse >> subresponses: aCollection [
	subresponses := LeClientUtility collectionWithoutNilItemsFrom: aCollection
]
