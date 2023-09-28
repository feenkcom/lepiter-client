Trait {
	#name : #TLeClientWithCommands,
	#instVars : [
		'commands'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
TLeClientWithCommands >> addCommand: aCommand [
	self commands: (self commands copyWith: aCommand)
]

{ #category : #accessing }
TLeClientWithCommands >> commands [
	^ commands ifNil: [ #() ]
]

{ #category : #accessing }
TLeClientWithCommands >> commands: anObject [
	commands := anObject
]
