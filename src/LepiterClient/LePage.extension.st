Extension { #name : #LePage }

{ #category : #'*LepiterClient' }
LePage >> gtExportActionFor: anAction [
	<lePageAction>

	^ anAction dropdown 
		tooltip: 'Publish Post';
		icon: BrGlamorousVectorIcons link;
		content: [:aButton | (GtApPublishPostForm new
						page: self;
						anchor: aButton)]
]
