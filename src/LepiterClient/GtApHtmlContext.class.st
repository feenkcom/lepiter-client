Class {
	#name : #GtApHtmlContext,
	#superclass : #LeHtmlContext,
	#instVars : [
		'serverDatabase',
		'pagePath'
	],
	#category : #'LepiterClient-Export'
}

{ #category : #accessing }
GtApHtmlContext >> pagePath [
	^ pagePath
]

{ #category : #accessing }
GtApHtmlContext >> pagePath: anObject [
	pagePath := anObject
]

{ #category : #accessing }
GtApHtmlContext >> serverDatabase [
	^ serverDatabase
]

{ #category : #accessing }
GtApHtmlContext >> serverDatabase: anObject [
	serverDatabase := anObject
]
