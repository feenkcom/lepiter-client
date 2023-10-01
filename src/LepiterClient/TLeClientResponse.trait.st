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
TLeClientResponse >> isSuccess [
	^ false
]

{ #category : #accessing }
TLeClientResponse >> label [
	^ self description asRopedText foreground: self color
]
