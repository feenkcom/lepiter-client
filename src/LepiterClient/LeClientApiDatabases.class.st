Class {
	#name : #LeClientApiDatabases,
	#superclass : #LeClientCommand,
	#category : #'LepiterClient-Publishing New'
}

{ #category : #'api - actions' }
LeClientApiDatabases >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	aResponse := self context client
			endpoint: LeClientEndpoints apiDatabases;
			authenticated;
			onSuccessLepiterModel: [ :aCollection "set context" | 
				aCollection
					do: [ :aDatabase | 
						aDatabase
							server: self context serverUrl;
							token: self context token ] ];
			get.

	self addResponse: aResponse.
	^ aResponse
]

{ #category : #'api - actions' }
LeClientApiDatabases >> prepare [
	"do nothing"

	
]
