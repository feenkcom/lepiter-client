Class {
	#name : #LeClientCompositeCommand,
	#superclass : #LeClientCommand,
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientCompositeCommand class >> endPoint [
	"Composite command have no endpoint"
	
	^ nil
]
