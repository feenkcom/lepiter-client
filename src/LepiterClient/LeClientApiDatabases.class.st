Class {
	#name : #LeClientApiDatabases,
	#superclass : #LeClientApiCommand,
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientApiDatabases class >> endPoint [
	^ LeClientEndpoints apiDatabases
]

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
					do: [ :aLeClientOrganization | aLeClientOrganization context: self context ] ];
			get.

	self addResponse: aResponse.
	^ aResponse
]

{ #category : #'api - actions' }
LeClientApiDatabases >> prepare [
	"do nothing"
]
