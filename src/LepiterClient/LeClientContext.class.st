Class {
	#name : #LeClientContext,
	#superclass : #Object,
	#traits : 'TGtOptions',
	#classTraits : 'TGtOptions classTrait',
	#instVars : [
		'serverUrl',
		'token',
		'username',
		'password',
		'builder'
	],
	#category : #'LepiterClient-Client New'
}

{ #category : #builders }
LeClientContext >> client [
	^ LepiterClient new context: self
]

{ #category : #builders }
LeClientContext >> close [
	self isCaching ifFalse: [ ^ self ].
	builder ifNotNil: [ 
		builder close.
		builder := nil ]
]

{ #category : #initalization }
LeClientContext >> initialize [
	super initialize.
	"builder := #doNotCache"
]

{ #category : #testing }
LeClientContext >> isCaching [
	^ builder ~= #doNotCache
]

{ #category : #builders }
LeClientContext >> newZincClientBuilder [
	^ LeClientZincClientBuilder new context: self
]

{ #category : #accessing }
LeClientContext >> password [
	<return: #String>
	^ password
]

{ #category : #accessing }
LeClientContext >> password: aString [
	password := aString
]

{ #category : #'options - post' }
LeClientContext >> postAuthorName [
	<return: #String or: nil>
	^ self optionAt: #postAuthorName ifAbsent: [ nil ]
]

{ #category : #'options - post' }
LeClientContext >> postAuthorName: aString [
	self optionAt: #postAuthorName put: aString
]

{ #category : #'options - post' }
LeClientContext >> postPublishDate [
	<return: #DateAndTime or: nil>
	^ self optionAt: #postPublishDate ifAbsent: [ nil ]
]

{ #category : #'options - post' }
LeClientContext >> postPublishDate: aDate [
	self optionAt: #postPublishDate put: aDate
]

{ #category : #accessing }
LeClientContext >> printOn: aStream [
	super printOn: aStream.

	self serverUrl ifNil: [ ^ self ].
	self username ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: self username asString;
		nextPutAll: ' @ ';
		print: self serverUrl.
	self token ifNotNil: [ 
		aStream nextPutAll: ' with token' ].
	aStream	
		nextPut: $)
]

{ #category : #accessing }
LeClientContext >> serverUrl [
	<return: #ZnUrl>
	^ serverUrl
]

{ #category : #accessing }
LeClientContext >> serverUrl: anUrl [
	serverUrl := anUrl asZnUrl
]

{ #category : #accessing }
LeClientContext >> token [
	<return: #String>
	^ token
]

{ #category : #accessing }
LeClientContext >> token: aString [
	token := aString
]

{ #category : #accessing }
LeClientContext >> username [
	<return: #String>
	^ username
]

{ #category : #accessing }
LeClientContext >> username: aString [
	username := aString
]

{ #category : #builders }
LeClientContext >> zinc [
	^ self isCaching
		ifTrue: [ builder ifNil: [ builder := self newZincClientBuilder ] ]
		ifFalse: [ self newZincClientBuilder ]
]
