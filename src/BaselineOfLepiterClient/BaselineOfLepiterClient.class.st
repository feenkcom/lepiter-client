Class {
	#name : #BaselineOfLepiterClient,
	#superclass : #BaselineOf,
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
	^ spec for: #common do: [ spec package: 'LepiterClient' ]
]
