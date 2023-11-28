Class {
	#name : #LeClientCommand,
	#superclass : #Object,
	#traits : 'TLeClientCommand',
	#classTraits : 'TLeClientCommand classTrait',
	#instVars : [
		'context'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientCommand class >> endPoint [
	"Return a string resource path used by me, as in /api/databases"

	self subclassResponsibility
]

{ #category : #accessing }
LeClientCommand >> context [
	<retuarn: #LeClientContext>
	^ context
]

{ #category : #accessing }
LeClientCommand >> context: aContext [
	context := aContext
]

{ #category : #'api - actions' }
LeClientCommand >> execute [
	"Perform a main command action.
	It is assumed that #prepare was called prior this call."

	<return: #TLeClientResponse>
	^ self subclassResponsibility
]

{ #category : #'gt - extensions' }
LeClientCommand >> gtDetails [
	^ {
		{ 'command' . self class name . self }.
		{ 'description' . self description }.
		{ 'success' . self isSuccess }.
		{ 'subcommands' . self commands size . self commands }.
		{ 'responses' . self responses size . self responses }.
		{ 'last response' 
			. self lastResponse classAndDescription
			. self lastResponse }
	}
]

{ #category : #'gt - extensions' }
LeClientCommand >> gtDetailsFor: aView [
	<gtView>
	^ aView columnedList
		  title: 'Details';
		  priority: 30;
		  items: [ self gtDetails ];
		  column: 'Key' text: #first;
		  column: 'Value' text: #second weight: 5;
		  sendTool: [ :spec | | target |
		  	target := spec last.
		  	(target notNil and: [ target isClass ])
		  		ifTrue: [ GtClassCoderTool forClass: target ]
		  		ifFalse: [ target gtDefaultInspectorTool ] ]
]

{ #category : #'api - actions' }
LeClientCommand >> prepare [
	"Prepare (initialize) this command.
	It may instantiate subcommands too.
	It should initialize or update the command state."

	self subclassResponsibility
]
