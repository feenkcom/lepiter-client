Class {
	#name : #LeClientRequestUtility,
	#superclass : #Object,
	#category : #'LepiterClient-Publishing'
}

{ #category : #utilities }
LeClientRequestUtility class >> responseForZnClient: aZnClient [
	^ aZnClient response isSuccess
		ifTrue: [ LeClientRequestSuccess new
				request: aZnClient request;
				response: aZnClient response ]
		ifFalse: [ LeClientRequestFailure new
				request: aZnClient request;
				response: aZnClient response ]
]
