Class {
	#name : #LeClientRequestSuccess,
	#superclass : #Object,
	#traits : 'TGtApLepiterResponse + TGtApLepiterZnClient',
	#classTraits : 'TGtApLepiterResponse classTrait + TGtApLepiterZnClient classTrait',
	#instVars : [
		'znClient',
		'model'
	],
	#category : #'LepiterClient-Publishing'
}

{ #category : #testing }
LeClientRequestSuccess >> isSuccess [
	^ true
]

{ #category : #accessing }
LeClientRequestSuccess >> model [
	^ model
]

{ #category : #accessing }
LeClientRequestSuccess >> model: anObject [
	model := anObject
]

{ #category : #accessing }
LeClientRequestSuccess >> znClient [
	^ znClient
]

{ #category : #accessing }
LeClientRequestSuccess >> znClient: anObject [
	znClient := anObject
]
