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

	self subclassResponsibility
]

{ #category : #'api - actions' }
LeClientCommand >> prepare [
	"Prepare (initialize) this command.
	It may instantiate subcommands too.
	It should initialize or update the command state."

	self subclassResponsibility
]
