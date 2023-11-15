Class {
	#name : #LeClientApiPosts,
	#superclass : #LeClientCommand,
	#instVars : [
		'organization'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientApiPosts >> description [
	^ 'Get posts owned by {1}' format: { self organization }
]

{ #category : #accessing }
LeClientApiPosts >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	aResponse := self context zinc
			endpoint: LeClientEndpoints apiPosts;
			authenticated;
			queryAt: #database put: self organization lepiterDatabase asString;
			onSuccessLepiterModel;
			get.
	self addResponse: aResponse.
	^ aResponse
]

{ #category : #accessing }
LeClientApiPosts >> organization [
	<return: #LeClientOrganizatoin>
	^ organization
]

{ #category : #accessing }
LeClientApiPosts >> organization: leClientOrganization [
	organization := leClientOrganization
]

{ #category : #accessing }
LeClientApiPosts >> prepare [
	"do nothing"
]
