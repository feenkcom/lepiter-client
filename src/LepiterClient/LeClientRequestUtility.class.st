Class {
	#name : #LeClientRequestUtility,
	#superclass : #Object,
	#category : #'LepiterClient-Publishing'
}

{ #category : #utilities }
LeClientRequestUtility class >> responseForZnClient: aZnClient [
	^ aZnClient response isSuccess
		ifTrue: [ LeClientRequestSuccess new znClient: aZnClient ]
		ifFalse: [ LeClientRequestFailure new znClient: aZnClient ]
]
