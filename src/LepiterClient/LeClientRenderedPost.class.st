Class {
	#name : #LeClientRenderedPost,
	#superclass : #Object,
	#instVars : [
		'post',
		'filePath'
	],
	#category : #'LepiterClient-Responses'
}

{ #category : #accessing }
LeClientRenderedPost >> filePath [
	<return: #String>
	^ filePath
]

{ #category : #accessing }
LeClientRenderedPost >> filePath: aString [
	self
		assert: [ aString isString ]
		description: [ 'File path must be a string: {1}' format: {aString} ].
	filePath := aString
]

{ #category : #accessing }
LeClientRenderedPost >> post [
	<return: #LeClientPost>
	^ post
]

{ #category : #accessing }
LeClientRenderedPost >> post: anObject [
	post := anObject
]
