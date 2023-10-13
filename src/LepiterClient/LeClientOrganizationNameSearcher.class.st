Class {
	#name : #LeClientOrganizationNameSearcher,
	#superclass : #LeClientCommand,
	#instVars : [
		'apiDatabases',
		'organizationName'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientOrganizationNameSearcher >> commands [
	^ LeClientUtility collectionWithoutNilItemFrom: apiDatabases
]

{ #category : #accessing }
LeClientOrganizationNameSearcher >> databaseName [
	^ organizationName
]

{ #category : #accessing }
LeClientOrganizationNameSearcher >> databaseName: anObject [
	organizationName := anObject
]

{ #category : #accessing }
LeClientOrganizationNameSearcher >> description [
	^ String
		streamContents: [ :aStream | 
			aStream
				nextPutAll: 'Get organization named: ';
				nextPutAll: (organizationName ifNil: [ '<undefined>' ]) ]
]

{ #category : #'api - actions' }
LeClientOrganizationNameSearcher >> execute [
	<return: #TLeClientResponse>
	| aDbsResponse aResponse |
	self
		ifSuccess: [ :aPreviousResponse | ^ aPreviousResponse ]
		ifFailure: [  "repeat" ]
		ifNone: [  "execute" ].

	aDbsResponse := apiDatabases execute.

	aResponse := aDbsResponse
			ifSuccess: [ aDbsResponse model
					detect: [ :eachDb | eachDb name = organizationName ]
					ifFound: [ :aDb | 
						LeClientFoundOrganization new
							database: aDb;
							databaseName: organizationName;
							subresponse: aDbsResponse ]
					ifNone: [ LeClientNoneOrganization new
							databaseName: organizationName;
							subresponse: aDbsResponse ] ]
			ifFailure: [ LeClientCannotExecute new subresponse: aDbsResponse ]
			ifNone: [ LeClientCannotExecute new subresponse: aDbsResponse ].
	self addResponse: aResponse.
	^ aResponse
]

{ #category : #'api - actions' }
LeClientOrganizationNameSearcher >> prepare [
	apiDatabases := LeClientApiDatabases new context: self context.
	apiDatabases prepare
]
