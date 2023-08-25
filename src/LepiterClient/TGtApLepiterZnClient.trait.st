Trait {
	#name : #TGtApLepiterZnClient,
	#category : #'LepiterClient-Publishing'
}

{ #category : #accessing }
TGtApLepiterZnClient >> code [
	<return: #Integer>
	^ self statusLine code
]

{ #category : #accessing }
TGtApLepiterZnClient >> contentType [
	<return: #ZnMimeType>
	^ self response contentType
]

{ #category : #accessing }
TGtApLepiterZnClient >> contents [
	^ self znClient response contents
]

{ #category : #accessing }
TGtApLepiterZnClient >> entity [
	<return: #ZnEntity>
	^ self response entity
]

{ #category : #testing }
TGtApLepiterZnClient >> hasEntity [
	<return: #Boolean>
	^ self response hasEntity
]

{ #category : #testing }
TGtApLepiterZnClient >> isNoContent [
	<return: #Boolean>
	^ self response isNoContent
]

{ #category : #accessing }
TGtApLepiterZnClient >> method [
	<return: #ZnRequest>
	^ self requestLine method
]

{ #category : #printing }
TGtApLepiterZnClient >> printOn: stream [
	super printOn: stream.
	stream nextPut: $(.
	"Request"
	self requestLine printMethodAndUriOn: stream.
	
	stream nextPutAll: ': '.
	
	"Response"
	self statusLine printCodeAndReasonOn: stream.
	self hasEntity ifTrue: [
		stream space.
		self entity printContentTypeAndLengthOn: stream ].
	
	stream nextPut: $)
]

{ #category : #accessing }
TGtApLepiterZnClient >> reason [
	<return: #String>
	^ self statusLine reason
]

{ #category : #accessing }
TGtApLepiterZnClient >> request [
	<return: #ZnRequest>
	^ self znClient request
]

{ #category : #accessing }
TGtApLepiterZnClient >> requestLine [
	<return: #ZnRequestLine>
	^ self request requestLine
]

{ #category : #accessing }
TGtApLepiterZnClient >> response [
	<return: #ZnResponse>
	^ self znClient response
]

{ #category : #accessing }
TGtApLepiterZnClient >> statusLine [
	<return: #ZnRequestLine>
	^ self response statusLine
]

{ #category : #accessing }
TGtApLepiterZnClient >> uriPathQueryFragment [
	<return: #String>
	^ self requestLine uriPathQueryFragment
]

{ #category : #accessing }
TGtApLepiterZnClient >> znClient [
	<return: #ZnClient>
	^ self explicitRequirement
]
