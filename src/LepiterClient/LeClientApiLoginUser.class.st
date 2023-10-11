Class {
	#name : #LeClientApiLoginUser,
	#superclass : #LeClientCommand,
	#category : #'LepiterClient-Publishing New'
}

{ #category : #'api - actions' }
LeClientApiLoginUser >> execute [
	| aResponse |
	aResponse := self context client
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