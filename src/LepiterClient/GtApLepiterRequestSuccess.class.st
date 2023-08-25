Class {
	#name : #GtApLepiterRequestSuccess,
	#superclass : #Object,
	#traits : 'TGtApLepiterResponse + TGtApLepiterZnClient',
	#classTraits : 'TGtApLepiterResponse classTrait + TGtApLepiterZnClient classTrait',
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
