Trait {
	#name : #TLeClientContentsProvider,
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
TLeClientContentsProvider >> bytes [
	<return: #ByteArray>
	^ self explicitRequirement
]

{ #category : #accessing }
TLeClientContentsProvider >> name [
	<return: #String>
	^ self explicitRequirement
]
