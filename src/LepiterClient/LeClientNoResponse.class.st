Class {
	#name : #LeClientNoResponse,
	#superclass : #Object,
	#traits : 'TLeClientResponse',
	#classTraits : 'TLeClientResponse classTrait',
	#category : #'LepiterClient-Responses'
}

{ #category : #accessing }
LeClientNoResponse class >> defaultColor [
	^ BrGlamorousColors disabledButtonTextColor
]

{ #category : #accessing }
LeClientNoResponse class >> defaultDescription [
	^ 'not executed'
]

{ #category : #accessing }
LeClientNoResponse >> color [
	^ self class defaultColor
]

{ #category : #accessing }
LeClientNoResponse >> description [
	^ self class defaultDescription
]

{ #category : #testing }
LeClientNoResponse >> ifExist: existBlock ifMissing: missingBlock ifFailure: failureBlock ifNone: noneBlock [
	^ noneBlock value
]

{ #category : #testing }
LeClientNoResponse >> ifSuccess: successBlock ifFailure: failureBlock ifNone: noneBlock [
	^ noneBlock value
]

{ #category : #accessing }
LeClientNoResponse >> model [
	"Return a domain object or nil."

	^ nil
]
