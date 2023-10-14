Trait {
	#name : #TLeClientExceptionViews,
	#category : #'LepiterClient-Responses'
}

{ #category : #accessing }
TLeClientExceptionViews >> exception [
	<return: #Exception or: nil>
	^ self explicitRequirement
]

{ #category : #'gt - extensions' }
TLeClientExceptionViews >> gtExceptionMessageTextFor: aView [
	<gtView>
	^ aView forward
		title: 'Exception message';
		priority: 15;
		object: [ self exception ];
		view: #gtMessageTextFor:
]

{ #category : #'gt - extensions' }
TLeClientExceptionViews >> gtExceptionStackFor: aView [
	<gtView>
	self exception ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Exception stack';
		priority: 10;
		object: [ self exception ];
		view: #gtLiveFor:
]
