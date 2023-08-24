Class {
	#name : #GtApLepiterRequestFailure,
	#superclass : #Object,
	#traits : 'TGtApLepiterResponse',
	#classTraits : 'TGtApLepiterResponse classTrait',
	#instVars : [
		'znClient'
	],
	#category : #'LepiterClient-Publishing'
}

{ #category : #accessing }
GtApLepiterRequestFailure >> znClient [
	^ znClient
]

{ #category : #accessing }
GtApLepiterRequestFailure >> znClient: anObject [
	znClient := anObject
]
