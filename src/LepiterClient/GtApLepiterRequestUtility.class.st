Class {
	#name : #GtApLepiterRequestUtility,
	#superclass : #Object,
	#category : #'LepiterClient-Publishing'
}

{ #category : #utilities }
GtApLepiterRequestUtility class >> responseForZnClient: aZnClient [
	^ aZnClient response isSuccess
		ifTrue: [ GtApLepiterRequestSuccess new znClient: aZnClient ]
		ifFalse: [ GtApLepiterRequestFailure new znClient: aZnClient ]
]
