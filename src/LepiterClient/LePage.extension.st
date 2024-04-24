Extension { #name : #LePage }

{ #category : #'*LepiterClient' }
LePage >> gtExportActionFor: anAction [
	<lePageAction>
	^ anAction dropdown
		tooltip: 'Publish Post';
		icon: BrGlamorousVectorIcons link;
		content: [ :aButton | 
			(LeClientLoginPane new
				onLogin: [ :aClient | 
					BlTaskAction 
						enqueueElement: aButton 
						action: [
							aButton phlow
								spawnObject: (LePagePublishClient new
										page: self;
										client: aClient) ] ]) asElement ]
]
