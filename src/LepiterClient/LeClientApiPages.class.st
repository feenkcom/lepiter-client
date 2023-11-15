Class {
	#name : #LeClientApiPages,
	#superclass : #LeClientCommand,
	#instVars : [
		'organization'
	],
	#category : #'LepiterClient-Publishing New'
}

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
