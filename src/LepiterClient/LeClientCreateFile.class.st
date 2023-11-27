Class {
	#name : #LeClientCreateFile,
	#superclass : #Object,
	#instVars : [
		'jsonObject',
		'contentsProvider'
	],
	#category : #'LepiterClient-Responses'
}

{ #category : #accessing }
LeClientCreateFile >> blob [
	<return: #String or: nil>
	^ jsonObject ifNotNil: [ :anObject | anObject at: #blob ifAbsent: [ nil ] ]
]

{ #category : #accessing }
LeClientCreateFile >> contentsProvider [
	<return: #TLeClientContentsProvider>
	^ contentsProvider
]

{ #category : #accessing }
LeClientCreateFile >> contentsProvider: anObject [
	contentsProvider := anObject
]

{ #category : #'gt - extensions' }
LeClientCreateFile >> gtDetailsFor: aView [
	<gtView>
	^ aView columnedList
		  title: 'Details';
		  priority: 30;
		  items: [ {
		  	{ 'contents provider' . self contentsProvider }.
		  	{ 'json object' . self jsonObject }
		  } ];
		  column: 'Key' text: #first;
		  column: 'Value' text: #second weight: 5;
		  send: #last
]

{ #category : #accessing }
LeClientCreateFile >> jsonObject [
	<return: #Dictionary or: #Array>
	^ jsonObject
]

{ #category : #accessing }
LeClientCreateFile >> jsonObject: anObject [
	jsonObject := anObject
]
