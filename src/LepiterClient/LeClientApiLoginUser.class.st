Class {
	#name : #LeClientApiLoginUser,
	#superclass : #LeClientCommand,
	#category : #'LepiterClient-Publishing New'
}

{ #category : #'api - actions' }
LeClientApiLoginUser >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	aResponse := self context zinc
			endpoint: LeClientEndpoints apiLoginUser;
			noAuthentication;
			jsonObject: self jsonObject;
			onSuccessJsonModel: [ :aJsonObject | 
				aJsonObject
					at: #token
					ifPresent: [ :aToken | self context token: aToken ]
					ifAbsent: [  "ignore" ].
				aJsonObject ];
			post.
	self addResponse: aResponse.
	^ aResponse
]

{ #category : #'gt - extensions' }
LeClientApiLoginUser >> gtDetails [
	^ super gtDetails , {
		{ 'username' . self context username }.
		{ 'password' . self context password }
	}
]

{ #category : #private }
LeClientApiLoginUser >> jsonObject [
	^ {'username' -> self context username.
		'password' -> self context password} asDictionary
]

{ #category : #'api - actions' }
LeClientApiLoginUser >> prepare [
	"do nothing"

	
]
