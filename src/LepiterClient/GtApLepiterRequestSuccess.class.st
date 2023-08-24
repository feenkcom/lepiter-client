Class {
	#name : #GtApLepiterRequestSuccess,
	#superclass : #Object,
	#traits : 'TGtApLepiterResponse',
	#classTraits : 'TGtApLepiterResponse classTrait',
	#instVars : [
		'znClient'
	],
	#category : #'LepiterClient-Publishing'
}

{ #category : #testing }
GtApLepiterRequestSuccess >> isSuccess [
	^ true
]

{ #category : #accessing }
GtApLepiterRequestSuccess >> znClient [
	^ znClient
]

{ #category : #accessing }
GtApLepiterRequestSuccess >> znClient: anObject [
	znClient := anObject
]
