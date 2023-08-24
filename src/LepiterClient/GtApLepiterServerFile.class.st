Class {
	#name : #GtApLepiterServerFile,
	#superclass : #Object,
	#instVars : [
		'blob',
		'fileName'
	],
	#category : #'LepiterClient-Publishing'
}

{ #category : #accessing }
GtApLepiterServerFile >> blob [
	^ blob
]

{ #category : #accessing }
GtApLepiterServerFile >> blob: anObject [
	blob := anObject
]

{ #category : #accessing }
GtApLepiterServerFile >> fileName [
	^ fileName
]

{ #category : #accessing }
GtApLepiterServerFile >> fileName: anObject [
	fileName := anObject
]
