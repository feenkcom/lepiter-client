Class {
	#name : #LeClientNoActionCommand,
	#superclass : #LeClientCommand,
	#instVars : [
		'description'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #'instance creation' }
LeClientNoActionCommand class >> ready [
	^ self new addResponse: LeClientReadyResponse new
]

{ #category : #'instance creation' }
LeClientNoActionCommand class >> ready: aDescription [
	^ self ready description: aDescription
]

{ #category : #accessing }
LeClientNoActionCommand >> description [
	^ description ifNil: [ 'No action required' ]
]

{ #category : #accessing }
LeClientNoActionCommand >> description: aString [
	description := aString
]

{ #category : #'api - responses' }
LeClientNoActionCommand >> execute [
	^ self lastResponse
]

{ #category : #'api - responses' }
LeClientNoActionCommand >> prepare [
	"do nothing"

	
]
