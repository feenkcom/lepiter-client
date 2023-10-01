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
TLeClientWithCommands >> command [
	<return: #TLeClientCommand or: nil>
	^ self commands
		ifEmpty: [ nil ]
		ifNotEmpty: [ :aCollection | 
			aCollection size = 1
				ifFalse: [ self error: 'Use #command only when there is one subcommand.' ]
				ifTrue: [ aCollection anyOne ] ]
]

{ #category : #accessing }
TLeClientWithCommands >> commands [
	<return: #Collection of: #TLeClientCommand>
	^ commands ifNil: [ #() ]
]

{ #category : #accessing }
TLeClientWithCommands >> commands: anObject [
	commands := anObject
]
