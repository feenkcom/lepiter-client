Class {
	#name : #LeClientFile,
	#superclass : #Object,
	#instVars : [
		'blob',
		'fileName'
	],
	#category : #'LepiterClient-Publishing'
}

{ #category : #accessing }
LeClientFile >> blob [
	^ blob
]

{ #category : #accessing }
LeClientFile >> blob: anObject [
	blob := anObject
]

{ #category : #accessing }
LeClientFile >> fileName [
	^ fileName
]

{ #category : #accessing }
LeClientFile >> fileName: anObject [
	fileName := anObject
]
