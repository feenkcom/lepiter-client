Class {
	#name : #GtApHtmlContext,
	#superclass : #LeHtmlContext,
	#instVars : [
		'serverDatabase'
	],
	#category : #'LepiterClient-Export'
}

{ #category : #accessing }
GtApHtmlContext >> serverDatabase [
	^ serverDatabase
]

{ #category : #accessing }
GtApHtmlContext >> serverDatabase: anObject [
	serverDatabase := anObject
]
