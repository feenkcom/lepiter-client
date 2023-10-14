Class {
	#name : #LeClientContext,
	#superclass : #Object,
	#instVars : [
		'serverUrl',
		'token',
		'username',
		'password'
	],
	#category : #'LepiterClient-Client New'
}

{ #category : #builders }
LeClientContext >> client [
	^ LepiterClient new context: self
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

{ #category : #accessing }
LeClientContext >> printOn: aStream [
	super printOn: aStream.

	self serverUrl ifNil: [ ^ self ].
	self username ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: self username asString;
		nextPutAll: ' at ';
		print: self serverUrl;
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
	^ LeClientZincClientBuilder new context: self
]
