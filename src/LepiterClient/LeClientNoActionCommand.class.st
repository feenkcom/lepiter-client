Class {
	#name : #LeClientNoActionCommand,
	#superclass : #LeClientCommand,
	#category : #'LepiterClient-Publishing New'
}

{ #category : #'instance creation' }
LeClientNoActionCommand class >> ready [
	^ self new addResponse: LeClientReadyResponse new
]

{ #category : #'api - responses' }
LeClientNoActionCommand >> execute [
	^ self lastResponse
]

{ #category : #'api - responses' }
LeClientNoActionCommand >> prepare [
	"do nothing"

	
]
