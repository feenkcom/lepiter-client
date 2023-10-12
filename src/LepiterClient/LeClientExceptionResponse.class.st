Class {
	#name : #LeClientExceptionResponse,
	#superclass : #Object,
	#traits : 'TLeClientResponse',
	#classTraits : 'TLeClientResponse classTrait',
	#instVars : [
		'exception'
	],
	#category : #'LepiterClient-Responses'
}

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
