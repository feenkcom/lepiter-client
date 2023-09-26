Trait {
	#name : #TGtApLepiterWithClient,
	#instVars : [
		'client'
	],
	#category : #'LepiterClient-Publishing'
}

{ #category : #accessing }
TGtApLepiterWithClient >> client [
	<return: #LepiterClient>
	^ client
]

{ #category : #accessing }
TGtApLepiterWithClient >> client: aClient [
	client := aClient
]

{ #category : #accessing }
TGtApLepiterWithClient >> server [
	<return: #String>
	^ self client server
]

{ #category : #accessing }
TGtApLepiterWithClient >> token [
	<return: #String>
	^ self client token
]
