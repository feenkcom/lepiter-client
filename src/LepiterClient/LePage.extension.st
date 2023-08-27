Extension { #name : #LePage }

{ #category : #'*LepiterClient' }
LePage >> gtExportActionFor: anAction [
	<lePageAction>
	| aFormCache |
	^ anAction dropdown
		tooltip: 'Publish Post';
		icon: BrGlamorousVectorIcons link;
		content: [ :aButton | 
			aFormCache ifNil: [ 
				aFormCache := GtApPublishPostForm new
					page: self;
					anchor: aButton ] ]
]
