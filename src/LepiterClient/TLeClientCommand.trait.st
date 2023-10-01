Trait {
	#name : #TLeClientCommand,
	#instVars : [
		'responses'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #'api - responses' }
TLeClientCommand >> addResponse: aResponse [
	self responses: (self responses copyWith: aResponse)
]

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

{ #category : #'api - actions' }
TLeClientCommand >> execute [
	"Perform a main command action.
	It is assumed that #prepare was called prior this call."

	self explicitRequirement
]

{ #category : #'gt - extensions' }
TLeClientCommand >> gtCommandsFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Actions';
		priority: 10;
		items: [ {self} ];
		children: #commands;
		expandAll;
		column: 'Description' text: #description;
		column: 'Response'
			text: [ :aCommand | aCommand lastResponse ifNotNil: #label ]
			width: 120;
		actionUpdateButton
]

{ #category : #'gt - extensions' }
TLeClientCommand >> gtResponsesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Responses';
		priority: 20;
		items: [ self responses ];
		column: 'Description' text: #label;
		actionUpdateButton
]

{ #category : #'api - responses' }
TLeClientCommand >> ifSuccessDo: successBlock ifFailureDo: failureBlock ifNone: noneBlock [
	^ self lastResponse
		ifNil: noneBlock
		ifNotNil: [ :aResponse | 
			aResponse isSuccess
				ifTrue: [ successBlock cull: aResponse ]
				ifFalse: [ failureBlock cull: aResponse ] ]
]

{ #category : #'api - responses' }
TLeClientCommand >> isSuccess [
	^ self
		ifSuccessDo: [ true ]
		ifFailureDo: [ false ]
		ifNone: [ false ]
]

{ #category : #'api - responses' }
TLeClientCommand >> lastResponse [
	<return: #TLeClientResponse or: nil>
	^ self responses ifEmpty: [ nil ] ifNotEmpty: #last
]

{ #category : #'api - actions' }
TLeClientCommand >> prepare [
	"Prepare (initialize) this command.
	It may instantiate subcommands too.
	It should initialize or update the command state."

	self explicitRequirement
]

{ #category : #'api - responses' }
TLeClientCommand >> responses [
	<return: #Collection of: #TLeClientResponse>
	^ responses ifNil: [ #() ]
]

{ #category : #'api - responses' }
TLeClientCommand >> responses: anObject [
	responses := anObject
]
