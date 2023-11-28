Class {
	#name : #LeClientApiPages,
	#superclass : #LeClientApiCommand,
	#instVars : [
		'organization'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientApiPages class >> endPoint [
	^ LeClientEndpoints apiPages
]

{ #category : #accessing }
LeClientApiPages >> description [
	^ 'Get pages owned by {1}' format: { self organization }
]

{ #category : #accessing }
LeClientApiPages >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	aResponse := self context zinc
			endpoint: LeClientEndpoints apiPages;
			authenticated;
			queryAt: #database put: self organization lepiterDatabase asString;
			onSuccessLepiterModel;
			get.
	self addResponse: aResponse.
	^ aResponse
]

{ #category : #'gt - extensions' }
LeClientApiPages >> gtDetails [
	^ super gtDetails , {
		{ 'organization' . self organization }
	}
]

{ #category : #accessing }
LeClientApiPages >> organization [
	<return: #LeClientOrganization>
	^ organization
]

{ #category : #accessing }
LeClientApiPages >> organization: leClientOrganization [
	organization := leClientOrganization
]

{ #category : #accessing }
LeClientApiPages >> prepare [
	"do nothing"
]
