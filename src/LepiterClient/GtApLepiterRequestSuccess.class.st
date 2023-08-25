Class {
	#name : #GtApLepiterRequestSuccess,
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
GtApLepiterRequestSuccess >> isSuccess [
	^ true
]

{ #category : #accessing }
GtApLepiterRequestSuccess >> model [
	^ model
]

{ #category : #accessing }
GtApLepiterRequestSuccess >> model: anObject [
	model := anObject
]

{ #category : #accessing }
GtApLepiterRequestSuccess >> znClient [
	^ znClient
]

{ #category : #accessing }
GtApLepiterRequestSuccess >> znClient: anObject [
	znClient := anObject
]
