Trait {
	#name : #TLeClientZincResponse,
	#category : #'LepiterClient-Responses'
}

{ #category : #accessing }
TLeClientZincResponse >> code [
	<return: #Integer>
	^ self statusLine code
]

{ #category : #accessing }
TLeClientZincResponse >> contentType [
	<return: #ZnMimeType>
	^ self response contentType
]

{ #category : #accessing }
TLeClientZincResponse >> contents [
	^ self response contents
]

{ #category : #printing }
TLeClientZincResponse >> description [
	^ String streamContents: [ :stream | 
			self statusLine printCodeAndReasonOn: stream ]
]

{ #category : #accessing }
TLeClientZincResponse >> entity [
	<return: #ZnEntity>
	^ self response entity
]

{ #category : #testing }
TLeClientZincResponse >> hasEntity [
	<return: #Boolean>
	^ self response hasEntity
]

{ #category : #testing }
TLeClientZincResponse >> isNoContent [
	<return: #Boolean>
	^ self response isNoContent
]

{ #category : #testing }
TLeClientZincResponse >> isNotFound [
	<return: #Boolean>
	^ self response isNotFound
]

{ #category : #accessing }
TLeClientZincResponse >> method [
	<return: #ZnRequest>
	^ self requestLine method
]

{ #category : #printing }
TLeClientZincResponse >> printOn: stream [
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
TLeClientZincResponse >> reason [
	<return: #String>
	^ self statusLine reason
]

{ #category : #accessing }
TLeClientZincResponse >> request [
	<return: #ZnRequest>
	^ self explicitRequirement
]

{ #category : #accessing }
TLeClientZincResponse >> requestLine [
	<return: #ZnRequestLine>
	^ self request requestLine
]

{ #category : #accessing }
TLeClientZincResponse >> response [
	<return: #ZnResponse>
	^ self explicitRequirement
]

{ #category : #accessing }
TLeClientZincResponse >> statusLine [
	<return: #ZnRequestLine>
	^ self response statusLine
]

{ #category : #accessing }
TLeClientZincResponse >> uriPathQueryFragment [
	<return: #String>
	^ self requestLine uriPathQueryFragment
]
