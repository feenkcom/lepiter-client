Class {
	#name : #LeClientDatabaseNameSearcher,
	#superclass : #LeClientCommand,
	#instVars : [
		'databaseName',
		'apiDatabases'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientDatabaseNameSearcher >> commands [
	^ LeClientUtility collectionWithoutNilItemFrom: apiDatabases
]

{ #category : #accessing }
LeClientDatabaseNameSearcher >> databaseName [
	^ databaseName
]

{ #category : #accessing }
LeClientDatabaseNameSearcher >> databaseName: anObject [
	databaseName := anObject
]

{ #category : #accessing }
LeClientDatabaseNameSearcher >> description [
	^ String
		streamContents: [ :aStream | 
			aStream
				nextPutAll: 'Get database named: ';
				nextPutAll: (databaseName ifNil: [ '<undefined>' ]) ]
]

{ #category : #'api - actions' }
LeClientDatabaseNameSearcher >> execute [
	<return: #TLeClientResponse>
	| aDbsResponse aResponse |
	self
		ifSuccess: [ :aPreviousResponse | ^ aPreviousResponse ]
		ifFailure: [  "repeat" ]
		ifNone: [  "execute" ].

	aDbsResponse := apiDatabases execute.

	aResponse := aDbsResponse
			ifSuccess: [ aDbsResponse model
					detect: [ :eachDb | eachDb name = databaseName ]
					ifFound: [ :aDb | 
						LeClientFoundDatabase new
							database: aDb;
							databaseName: databaseName;
							subresponse: aDbsResponse ]
					ifNone: [ LeClientNoneDatabase new
							databaseName: databaseName;
							subresponse: aDbsResponse ] ]
			ifFailure: [ LeClientCannotExecute new subresponse: aDbsResponse ]
			ifNone: [ LeClientCannotExecute new subresponse: aDbsResponse ].
	self addResponse: aResponse.
	^ aResponse
]

{ #category : #'api - actions' }
LeClientDatabaseNameSearcher >> prepare [
	apiDatabases := LeClientApiDatabases new context: self context.
	apiDatabases prepare
]
