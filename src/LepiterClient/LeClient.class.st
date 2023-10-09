Class {
	#name : #LeClient,
	#superclass : #Object,
	#instVars : [
		'context'
	],
	#category : #'LepiterClient-Client New'
}

{ #category : #'api - configuration' }
LeClient >> context [
	<return: #LeClientContext>
	^ context ifNil: [ context := self defaultContext ]
]

{ #category : #'api - configuration' }
LeClient >> context: aContext [
	context := aContext
]

{ #category : #'api - actions' }
LeClient >> createPost: aPost forPage: aPage inDatabase: aDatabaseId [
	"It creates or updates a post. It also create or update the given page."

	<return: #TLeClientCommand>
	^ LeClientPostPublisher new
		context: self context;
		post: aPost;
		page: aPage;
		serverDatabaseId: aDatabaseId asString;
		prepare;
		execute;
		yourself
]

{ #category : #'api - actions' }
LeClient >> databases [
	| aResponse |
	aResponse := LeClientApiDatabases new
			context: self context;
			prepare;
			execute.
	^ aResponse
		ifSuccess: #model
		ifFailure: [ #() ]
		ifNone: [ #() ]
]

{ #category : #initialization }
LeClient >> defaultContext [
	^ LeClientContext new serverUrl: LeClientEndpoints serverUrl
]

{ #category : #'api - actions' }
LeClient >> exportPage: aPage inDatabase: aDatabaseId [
	<return: #TLeClientCommand>
	^ LeClientPagePublisher new
		context: self context;
		page: aPage;
		serverDatabaseId: aDatabaseId asString;
		prepare;
		execute;
		yourself
]

{ #category : #'api - actions' }
LeClient >> findPostByPage: aPage [
	<return: #TLeClientCommand>
	^ LeClientApiPostByPage new
		context: context;
		page: aPage;
		prepare;
		execute;
		yourself
]

{ #category : #'api - actions' }
LeClient >> login [
	<return: #TLeClientCommand>
	^ LeClientLogin new
		context: self context;
		prepare;
		execute
]

{ #category : #'api - actions' }
LeClient >> lookupDatabase: aDbName [
	^ self databases detect: [ :aDb | aDb name = aDbName ]
]

{ #category : #'api - configuration' }
LeClient >> password: anUrl [
	self context password: anUrl
]

{ #category : #'api - configuration' }
LeClient >> server: anUrl [
	self serverUrl: anUrl
]

{ #category : #'api - configuration' }
LeClient >> serverUrl: anUrl [
	self context serverUrl: anUrl
]

{ #category : #'api - accessing' }
LeClient >> token [
	^ self context token
]

{ #category : #'api - configuration' }
LeClient >> username: anUrl [
	self context username: anUrl
]
