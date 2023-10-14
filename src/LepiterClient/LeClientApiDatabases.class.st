Class {
	#name : #LeClientApiDatabases,
	#superclass : #LeClientCommand,
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientApiDatabases >> description [
	^ 'Get organizations'
]

{ #category : #'api - actions' }
LeClientApiDatabases >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	aResponse := self context zinc
			endpoint: LeClientEndpoints apiDatabases;
			authenticated;
			onSuccessLepiterModel: [ :aCollection | 
				aCollection
					do: [ :aDatabase | 
						"TODO: set context instead"
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
