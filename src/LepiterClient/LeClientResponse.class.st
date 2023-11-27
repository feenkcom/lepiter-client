Class {
	#name : #LeClientResponse,
	#superclass : #Object,
	#traits : 'TLeClientResponse',
	#classTraits : 'TLeClientResponse classTrait',
	#category : #'LepiterClient-Responses'
}

{ #category : #'gt - extensions' }
LeClientResponse >> gtDetails [
	^ {
		{ 'response' . self class name . self }.
		{ 'description' . self description }.
		{ 'success' . self isSuccess }.
		{ 'exception' . self isException }.
		{ 'color' . 9632 asCharacter asString asRopedText foreground: self color . self color }.
		{ 'label' . self label }.
		{ 'subresponses' . self subresponses size . self subresponses }.
		{ 'model' . self model }
	}
]

{ #category : #'gt - extensions' }
LeClientResponse >> gtDetailsFor: aView [
	<gtView>
	^ aView columnedList
		  title: 'Details';
		  priority: 30;
		  items: [ self gtDetails ];
		  column: 'Key' text: #first;
		  column: 'Value' text: #second weight: 5;
		  send: #last
]
