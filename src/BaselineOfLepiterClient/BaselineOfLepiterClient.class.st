Class {
	#name : #BaselineOfLepiterClient,
	#superclass : #BaselineOf,
	#classVars : [
		'PostLoaded'
	],
	#category : #BaselineOfLepiterClient
}

{ #category : #accessing }
BaselineOfLepiterClient class >> gtDependencyAnalysisPreloadedBaselines [

	^ super gtDependencyAnalysisPreloadedBaselines copyWith:
		  BaselineOfGToolkit
]

{ #category : #baseline }
BaselineOfLepiterClient >> baseline: spec [
	<baseline>
	^ spec
		for: #common
		do: [ spec postLoadDoIt: #postLoadLepiterClient:.
			spec package: 'LepiterClient' ]
]

{ #category : #hooks }
BaselineOfLepiterClient >> postLoadLepiterClient: spec [
	(PostLoaded isNotNil and: [ PostLoaded ]) ifTrue: [ ^ self ].

	PostLoaded := true.

	LeJsonV4 cleanUniqueInstance
]
