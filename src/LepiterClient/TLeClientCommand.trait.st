Trait {
	#name : #TLeClientCommand,
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
TLeClientCommand >> commands [
	"Return a subcommands"

	^ #()
]

{ #category : #accessing }
TLeClientCommand >> description [
	"Return a string that describes the command."

	<return: #String>
	^ self printString
]

{ #category : #'gt - extensions' }
TLeClientCommand >> gtCommandsFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Actions';
		items: [ self commands ];
		children: #commands;
		expandAll;
		column: 'Description' text: #description
]

{ #category : #'api - actions' }
TLeClientCommand >> prepare [
	"Prepare (initialize) this command.
	It may instantiate subcommands too.
	It should initialize or update the command state."

	self explicitRequirement
]
