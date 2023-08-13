Class {
	#name : #BaselineOfLepiterClient,
	#superclass : #BaselineOf,
	#category : #BaselineOfLepiterClient
}

{ #category : #baseline }
BaselineOfLepiterClient >> baseline: spec [
	<baseline>
	^ spec
		for: #common
		do: [ spec
				baseline: 'GToolkit4Magritte'
				with: [ spec repository: 'github://feenkcom/gt4magritte:main/src' ].
			spec 
				baseline: 'LepiterEngineCore'
				with: [ spec repository: 'github://feenkcom/lepiter:main/src' ].
			spec package: 'LepiterClient' ]
]
