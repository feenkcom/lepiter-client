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
					aButton phlow
						spawnObject: (LePagePublishClient new
								client: aClient;
								page: self) ]) asElement ]
]
