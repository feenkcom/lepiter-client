Trait {
	#name : #TLeClientResponse,
	#category : #'LepiterClient-Responses'
}

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

{ #category : #testing }
TLeClientResponse >> ifSuccess: successBlock ifFailure: failureBlock ifNone: noneBlock [
	^ self isSuccess
		ifTrue: [ successBlock cull: self ]
		ifFalse: [ failureBlock cull: self ]
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
TLeClientResponse >> subresponses [
	"Return a collection of responses of commands that were execute as a part of this response."

	<return: #Collection of: #TLeClientResponse>
	^ #()
]
