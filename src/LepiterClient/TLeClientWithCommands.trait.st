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
	<return: #Collection of: #TLeClientCommand>
	^ commands ifNil: [ #() ]
]

{ #category : #accessing }
TLeClientWithCommands >> commands: aCollection [
	commands := aCollection
]
