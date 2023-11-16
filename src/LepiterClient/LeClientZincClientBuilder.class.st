Class {
	#name : #LeClientZincClientBuilder,
	#superclass : #Object,
	#instVars : [
		'context',
		'endpoint',
		'isAuthenticated',
		'entity',
		'client',
		'onSuccessModel',
		'queries',
		'subresponses'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #'api - configuration' }
LeClientZincClientBuilder >> addSubresponse: aResponse [
	self addSubresponses: { aResponse }
]

{ #category : #'api - configuration' }
LeClientZincClientBuilder >> addSubresponses: aCollection [
	subresponses := aCollection
]

{ #category : #'api - configuration' }
LeClientZincClientBuilder >> authenticated [
	isAuthenticated := true
]

{ #category : #'api - configuration' }
LeClientZincClientBuilder >> bytes: aByteArray [
	| anEntity |
	anEntity := ZnEntity bytes: aByteArray.
	self entity: anEntity
]

{ #category : #initialization }
LeClientZincClientBuilder >> close [
	client ifNotNil: [ 
		client close.
		client := nil.
		self resetClientConfiguration ]
]

{ #category : #building }
LeClientZincClientBuilder >> configureClient [
	client ifNil: [ self createClient ].
	client url: self url.
	isAuthenticated 
		ifTrue: [ client setBearerAuthentication: self context token ]
		ifFalse: [ client setBearerAuthentication: nil ].
	entity ifNotNil: [ client entity: entity ]
]

{ #category : #accessing }
LeClientZincClientBuilder >> context [
	<return: #LeClientContext>
	^ context
]

{ #category : #accessing }
LeClientZincClientBuilder >> context: aContext [
	context := aContext
]

{ #category : #building }
LeClientZincClientBuilder >> createClient [
	<return: #ZnClient>
	client := ZnClient new.
	client clientId: 'leClient'.
	client numberOfRetries: 2. "the default retryDelay is 1s, the default timeout is 30s"
	client autoResetEntityMethods: #(HEAD GET DELETE).
	self context isCaching ifFalse: [ client beOneShot ].
	^ client
]

{ #category : #accessing }
LeClientZincClientBuilder >> endpoint [
	<return: #String>
	^ endpoint
]

{ #category : #'api - configuration' }
LeClientZincClientBuilder >> endpoint: aString [
	endpoint := aString
]

{ #category : #accessing }
LeClientZincClientBuilder >> entity [
	<return: #ZnEntity>
	^ entity
]

{ #category : #'api - configuration' }
LeClientZincClientBuilder >> entity: aZnEntity [
	entity := aZnEntity
]

{ #category : #building }
LeClientZincClientBuilder >> get [
	<return: #TLeClientResponse>
	^ self safe: [ client get ]
]

{ #category : #initialization }
LeClientZincClientBuilder >> initialize [
	super initialize.
	isAuthenticated := false.
	queries := Dictionary new.
]

{ #category : #'api - configuration' }
LeClientZincClientBuilder >> jsonObject: aJsonObject [
	| aJsonString |
	aJsonString := STONJSON toString: aJsonObject.
	self jsonString: aJsonString
]

{ #category : #'api - configuration' }
LeClientZincClientBuilder >> jsonString: aJsonString [
	| anEntity |
	anEntity := ZnEntity json: aJsonString.
	self entity: anEntity
]

{ #category : #'api - configuration' }
LeClientZincClientBuilder >> lepiterObject: aLepiterObject [
	| aJsonString |
	aJsonString := LeJsonV4 uniqueInstance serialize: aLepiterObject.
	self jsonString: aJsonString
]

{ #category : #'api - configuration' }
LeClientZincClientBuilder >> noAuthentication [
	isAuthenticated := false
]

{ #category : #'api - configuration' }
LeClientZincClientBuilder >> onSuccessJsonModel [
	"Define a model object on successful request"

	self onSuccessJsonModel: [ :aJsonObject | aJsonObject ]
]

{ #category : #'api - configuration' }
LeClientZincClientBuilder >> onSuccessJsonModel: aBlock [
	"Define a model object on successful request"

	self
		onSuccessModel: [ :aZnResponse | 
			| aJsonObject |
			aJsonObject := STONJSON fromString: aZnResponse entity string.
			aBlock cull: aJsonObject cull: aZnResponse ]
]

{ #category : #'api - configuration' }
LeClientZincClientBuilder >> onSuccessLepiterModel [
	"Define a lepiter object on successful request"

	self onSuccessLepiterModel: [ :aLepiterObject | aLepiterObject ]
]

{ #category : #'api - configuration' }
LeClientZincClientBuilder >> onSuccessLepiterModel: aBlock [
	"Define a lepiter object on successful request"

	self
		onSuccessModel: [ :aZnResponse | 
			| aLepiterObject |
			aLepiterObject := LeJsonV4 uniqueInstance
					deserialize: aZnResponse entity string readStream.
			aBlock cull: aLepiterObject cull: aZnResponse ]
]

{ #category : #accessing }
LeClientZincClientBuilder >> onSuccessModel [
	<return: #BlockClosure>
	^ onSuccessModel
]

{ #category : #'api - configuration' }
LeClientZincClientBuilder >> onSuccessModel: aBlock [
	"Define a model object on successful request"

	onSuccessModel := aBlock
]

{ #category : #building }
LeClientZincClientBuilder >> post [
	<return: #TLeClientResponse>
	^ self safe: [ client post ]
]

{ #category : #'api - configuration' }
LeClientZincClientBuilder >> queryAt: aKey put: aValue [
	queries at: aKey put: aValue
]

{ #category : #building }
LeClientZincClientBuilder >> resetClientConfiguration [
	endpoint := entity := subresponses := onSuccessModel := nil.
	queries removeAll
]

{ #category : #building }
LeClientZincClientBuilder >> safe: aBlock [
	<return: #TLeClientResponse>
	| aResponse |
	self configureClient.
	[ aBlock value.
	aResponse := LeClientRequestUtility responseForZnClient: client ]
		on: NetworkError , InvalidSocketStatusException , PrimitiveFailed
		do: [ :anException | 
			aResponse := LeClientRequestExceptionResponse new
				request: client request;
				freeze: anException ].
	subresponses ifNotNil: [ :aCollection | aResponse subresponses: aCollection ].
	(aResponse isSuccess and: [ onSuccessModel isNotNil ])
		ifTrue: [ aResponse model: (onSuccessModel cull: client response) ].
	self resetClientConfiguration.
	^ aResponse
]

{ #category : #building }
LeClientZincClientBuilder >> url [
	| anUrl |
	anUrl := self context serverUrl / endpoint.
	queries keysAndValuesDo: [ :aKey :aValue | anUrl queryAt: aKey put: aValue ].
	^ anUrl
]
