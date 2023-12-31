Trait {
	#name : #TLeClientResponse,
	#category : #'LepiterClient-Responses'
}

{ #category : #accessing }
TLeClientResponse >> classAndDescription [
	^ 'a {1} ({2})' format: { self class name . self description }
]

{ #category : #accessing }
TLeClientResponse >> color [
	^ self isSuccess
		ifFalse: [ BrGlamorousColors errorBackgroundColor ]
		ifTrue: [ BrGlamorousColors successBackgroundColor ]
]

{ #category : #accessing }
TLeClientResponse >> description [
	^ self printString
]

{ #category : #'gt - extensions' }
TLeClientResponse >> gtResponsesFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Responses';
		priority: 20;
		items: [ { self } ];
		expandAll;
		children: #subresponses;
		column: 'Description' text: [ :each | each class name ];
		column: 'Response' text: #label;
		actionUpdateButton
]

{ #category : #testing }
TLeClientResponse >> ifSuccess: successBlock ifFailure: failureBlock ifNone: noneBlock [
	^ self isSuccess
		ifTrue: [ successBlock cull: self ]
		ifFalse: [ failureBlock cull: self ]
]

{ #category : #testing }
TLeClientResponse >> isException [
	^ false
]

{ #category : #testing }
TLeClientResponse >> isSuccess [
	^ false
]

{ #category : #accessing }
TLeClientResponse >> label [
	^ self description asRopedText foreground: self color
]

{ #category : #accessing }
TLeClientResponse >> model [
	"Return a domain object or nil."

	^ self explicitRequirement
]

{ #category : #accessing }
TLeClientResponse >> subresponses [
	"Return a collection of responses of commands that were execute as a part of this response."

	<return: #Collection of: #TLeClientResponse>
	^ #()
]
