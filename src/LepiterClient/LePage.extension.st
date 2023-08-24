Extension { #name : #LePage }

{ #category : #'*LepiterClient' }
LePage >> gtExportActionFor: anAction [
	<lePageAction>
	| aForm |
	^ anAction dropdown
		tooltip: 'Publish Post';
		icon: BrGlamorousVectorIcons link;
		content: [ :aButton | 
			aForm ifNil: [ 
				aForm := GtApPublishPostForm new
							page: self;
							anchor: aButton ] ]
]
