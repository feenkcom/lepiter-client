Class {
	#name : #LeClientApiCommand,
	#superclass : #LeClientCommand,
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientApiCommand class >> gtEndpointFor: aView [
	<gtView>
	<gtClassView>
	self isAbstract ifTrue: [ ^ aView empty ].
	
	^ aView columnedList
		  title: 'REST endpoint';
		  priority: 30;
		  items: [ {
		  	{ 'endpoint' . self endPoint }.
		  	{ 'server command' 
					. (GtApRestCall withAllSubclasses reject: #isAbstract) 
						detect: [ :each | each endPoint = self endPoint ] 
						ifNone: nil }
		  } ];
		  column: 'Key' text: #first;
		  column: 'Value' text: #second weight: 5;
		  sendTool: [ :spec | | target |
		  	target := spec last.
		  	(target notNil and: [ target isClass ])
		  		ifTrue: [ GtClassCoderTool forClass: target ]
		  		ifFalse: [ target gtDefaultInspectorTool ] ]
]

{ #category : #accessing }
LeClientApiCommand class >> isAbstract [
	^ self = LeClientApiCommand
]

{ #category : #accessing }
LeClientApiCommand >> gtDetails [
	| details |
	details := super gtDetails , {
		{ 'endpoint' . self class endPoint }.
		{ 'server command' 
			"prevent a dependency on lepiter-server"
			. ((self class environment at: #GtApRestCall ifPresent: [ :cls | cls withAllSubclasses ] ifAbsent: [ #() ])
					 reject: #isAbstract) 
						detect: [ :each | each endPoint = self class endPoint ] 
						ifNone: nil }
	}.
	(self jsonObject ifNil: [ self lepiterObject ]) 
		ifNotNil: [ :requestPayload |
			details := details copyWith: { 'request payload' . requestPayload } ].
	^ details
]

{ #category : #accessing }
LeClientApiCommand >> jsonObject [
	^ nil
]

{ #category : #accessing }
LeClientApiCommand >> lepiterObject [
	^ nil
]
