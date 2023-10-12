Class {
	#name : #LeClientHtmlContext,
	#superclass : #LeHtmlContext,
	#instVars : [
		'serverDatabase',
		'pagePath'
	],
	#category : #'LepiterClient-Export'
}

{ #category : #accessing }
LeClientHtmlContext >> pagePath [
	^ pagePath
]

{ #category : #accessing }
LeClientHtmlContext >> pagePath: anObject [
	pagePath := anObject
]

{ #category : #accessing }
LeClientHtmlContext >> serverDatabase [
	<return: #LeClientDatabase>
	^ serverDatabase
]

{ #category : #accessing }
LeClientHtmlContext >> serverDatabase: aLeClientDatabase [
	serverDatabase := aLeClientDatabase
]
